import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyOptionsPage extends StatefulWidget {
  const EmergencyOptionsPage({super.key});

  @override
  State<EmergencyOptionsPage> createState() => _EmergencyOptionsPageState();
}

class _EmergencyOptionsPageState extends State<EmergencyOptionsPage> {
  // Use state variables for the numbers so they can be changed.
  String _ambulanceNumber = '999'; // Default Bangladesh national emergency number
  String _doctorNumber = '+8801711000000'; // Default fictional doctor number

  // Function to show a confirmation dialog before making the call.
  Future<void> _showConfirmationDialog(BuildContext context, String number, String title) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Are you sure you want to call this number?\n\n$number'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _makePhoneCall(context, 'tel:$number');
              },
              child: const Text('Call'),
            ),
          ],
        );
      },
    );
  }

  // Function to make a phone call using a URL launcher.
  Future<void> _makePhoneCall(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Could not launch the phone call. Please try again or dial manually.',
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
  }

  // A new function to display a dialog for editing the numbers
  void _showEditNumbersDialog() {
    final ambulanceController = TextEditingController(text: _ambulanceNumber);
    final doctorController = TextEditingController(text: _doctorNumber);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Emergency Numbers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ambulanceController,
                decoration: const InputDecoration(labelText: 'Ambulance Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: doctorController,
                decoration: const InputDecoration(labelText: 'Doctor Number'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _ambulanceNumber = ambulanceController.text;
                  _doctorNumber = doctorController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maternity Emergency'),
        backgroundColor: const Color(0xFFAD1457),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditNumbersDialog,
            tooltip: 'Edit Numbers',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select an emergency contact:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Button for the ambulance
              ElevatedButton.icon(
                onPressed: () {
                  _showConfirmationDialog(context, _ambulanceNumber, 'Call Ambulance');
                },
                icon: const Icon(Icons.local_hospital, size: 24),
                label: Text('Call Ambulance ($_ambulanceNumber)', style: const TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Button for the doctor
              ElevatedButton.icon(
                onPressed: () {
                  _showConfirmationDialog(context, _doctorNumber, 'Call Doctor');
                },
                icon: const Icon(Icons.person, size: 24),
                label: Text('Call Doctor ($_doctorNumber)', style: const TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF06292),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}