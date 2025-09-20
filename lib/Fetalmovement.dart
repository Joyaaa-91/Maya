// File: ContractionTrackerPage.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContractionTrackerPage extends StatefulWidget {
  const ContractionTrackerPage({super.key});

  @override
  State<ContractionTrackerPage> createState() => _ContractionTrackerPageState();
}

class _ContractionTrackerPageState extends State<ContractionTrackerPage> {
  // A data model to store contraction details
  List<Contraction> contractions = [];

  // Variables for the timer
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isTiming = false;

  void _startStopwatch() {
    if (_isTiming) return; // Prevent multiple timers
    setState(() {
      _isTiming = true;
      _secondsElapsed = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isTiming) {
        timer.cancel();
      }
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopAndLogContraction() {
    if (!_isTiming) return; // Cannot stop if not timing

    // Cancel the timer
    _timer?.cancel();
    _isTiming = false;

    // Log the new contraction
    final newContraction = Contraction(
      duration: _secondsElapsed,
      timestamp: DateTime.now(),
    );

    setState(() {
      contractions.add(newContraction);
      // Sort in descending order to show the latest at the top
      contractions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });

    // Reset the timer display
    _secondsElapsed = 0;
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contraction Tracker"),
      ),
      body: Column(
        children: [
          _buildStopwatchCard(),
          const Divider(),
          _buildContractionHistory(),
        ],
      ),
    );
  }

  Widget _buildStopwatchCard() {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              _formatTime(_secondsElapsed),
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: _isTiming ? Colors.red : theme.textTheme.displayLarge!.color,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _isTiming
                    ? ElevatedButton.icon(
                  onPressed: _stopAndLogContraction,
                  icon: const Icon(Icons.stop),
                  label: const Text("Stop & Log"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                )
                    : ElevatedButton.icon(
                  onPressed: _startStopwatch,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Contraction"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractionHistory() {
    if (contractions.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            "Press 'Start' to begin timing your first contraction.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: contractions.length,
        itemBuilder: (context, index) {
          final contraction = contractions[index];
          final formattedTime = DateFormat('h:mm:ss a').format(contraction.timestamp);

          // Calculate the interval from the previous contraction
          String intervalText = "";
          if (index < contractions.length - 1) {
            final previousContraction = contractions[index + 1];
            final interval = contraction.timestamp.difference(previousContraction.timestamp);
            final intervalMinutes = (interval.inSeconds ~/ 60);
            final intervalSeconds = (interval.inSeconds % 60);
            intervalText = "Interval: $intervalMinutes m ${intervalSeconds} s";
          }

          return Card(
            elevation: 1.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                'Contraction ${contractions.length - index}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration: ${_formatTime(contraction.duration)}'),
                  if (intervalText.isNotEmpty) Text(intervalText),
                ],
              ),
              trailing: Text(formattedTime, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}

class Contraction {
  final int duration; // in seconds
  final DateTime timestamp;

  Contraction({required this.duration, required this.timestamp});
}