// FetalMovementAndContractionTrackerPage.dart

import 'dart:async';
import 'package:flutter/material.dart';

class FetalMovementAndContractionTrackerPage extends StatefulWidget {
  const FetalMovementAndContractionTrackerPage({super.key});

  @override
  State<FetalMovementAndContractionTrackerPage> createState() => _FetalMovementAndContractionTrackerPageState();
}

class _FetalMovementAndContractionTrackerPageState extends State<FetalMovementAndContractionTrackerPage> {
  // --- Fetal Movement (Kick Counting) State & Logic ---
  int _kickCount = 0;
  bool _isSessionActive = false;
  DateTime? _sessionStartTime;
  Duration _sessionDuration = Duration.zero;
  Timer? _sessionTimer;

  void _startSession() {
    setState(() {
      _isSessionActive = true;
      _kickCount = 0;
      _sessionStartTime = DateTime.now();
      _sessionDuration = Duration.zero;
      _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _sessionDuration = DateTime.now().difference(_sessionStartTime!);
        });
      });
    });
  }

  void _recordKick() {
    if (_isSessionActive) {
      setState(() {
        _kickCount++;
      });
    }
  }

  void _endSession() {
    _sessionTimer?.cancel();
    setState(() {
      _isSessionActive = false;
    });
    _showSessionSummary();
  }

  void _showSessionSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kick Counting Session Complete'),
          content: Text(
            'You recorded $_kickCount kicks in ${_formatDuration(_sessionDuration)}.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // --- Contraction Tracking State & Logic ---
  bool _isContractionActive = false;
  DateTime? _contractionStartTime;
  final List<Map<String, dynamic>> _contractionHistory = [];
  Timer? _contractionTimer;
  Duration _currentContractionDuration = Duration.zero;

  void _startStopContraction() {
    setState(() {
      _isContractionActive = !_isContractionActive;
      if (_isContractionActive) {
        // Start a new contraction
        _contractionStartTime = DateTime.now();
        _currentContractionDuration = Duration.zero;
        _contractionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _currentContractionDuration = DateTime.now().difference(_contractionStartTime!);
          });
        });
      } else {
        // Stop the current contraction
        _contractionTimer?.cancel();
        _logContraction();
      }
    });
  }

  void _logContraction() {
    if (_contractionStartTime == null) return;
    final now = DateTime.now();
    final duration = now.difference(_contractionStartTime!);
    final lastContractionEndTime = _contractionHistory.isNotEmpty
        ? _contractionHistory.last['end_time'] as DateTime
        : null;
    final interval = lastContractionEndTime != null
        ? _contractionStartTime!.difference(lastContractionEndTime)
        : null;
    _contractionHistory.add({
      'start_time': _contractionStartTime,
      'duration': duration,
      'interval': interval,
      'end_time': now,
    });
    _contractionHistory.sort((a, b) => b['start_time'].compareTo(a['start_time']));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _contractionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetal & Contraction Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fetal Movement (Kick Counting) Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Fetal Movement Tracker',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isSessionActive ? 'Session in Progress' : 'Start a Kick Counting Session',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    _isSessionActive
                        ? Column(
                      children: [
                        Text(
                          'Kicks: $_kickCount',
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Time: ${_formatDuration(_sessionDuration)}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _recordKick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(150, 60),
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.touch_app, size: 40),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: _endSession,
                          child: const Text('End Session'),
                        ),
                      ],
                    )
                        : ElevatedButton(
                      onPressed: _startSession,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'START',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Contraction Tracker Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Contraction Tracker',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isContractionActive
                          ? 'Current Contraction: ${_formatDuration(_currentContractionDuration)}'
                          : 'Press START to time your contraction',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _startStopContraction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isContractionActive ? Colors.red : Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isContractionActive ? 'STOP' : 'START',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Contraction History',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 200,
                      child: _contractionHistory.isEmpty
                          ? const Center(
                        child: Text(
                          'No contractions recorded yet.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )
                          : ListView.builder(
                        itemCount: _contractionHistory.length,
                        itemBuilder: (context, index) {
                          final contraction = _contractionHistory[index];
                          final duration = _formatDuration(contraction['duration']);
                          final interval = contraction['interval'] != null
                              ? 'Interval: ${_formatDuration(contraction['interval'] as Duration)}'
                              : 'First Contraction';
                          final startTime = (contraction['start_time'] as DateTime).toLocal().toString().split('.')[0];
                          return ListTile(
                            title: Text(
                              'Duration: $duration',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '$interval\nStart Time: $startTime',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: const Icon(Icons.access_time),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}