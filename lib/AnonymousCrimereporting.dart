// File: AnonymousCrimeReportPage.dart

import 'package:flutter/material.dart';
// Add this import
import 'package:cloud_firestore/cloud_firestore.dart';

class AnonymousCrimeReportPage extends StatefulWidget {
  const AnonymousCrimeReportPage({super.key});

  @override
  State<AnonymousCrimeReportPage> createState() =>
      _AnonymousCrimeReportPageState();
}

class _AnonymousCrimeReportPageState extends State<AnonymousCrimeReportPage> {
  final TextEditingController _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _submitReport() async { // Make the function async
    final reportText = _reportController.text;
    if (reportText.isNotEmpty) {
      try {
        // Get a reference to the 'crime_reports' collection in Firestore
        CollectionReference reports = FirebaseFirestore.instance.collection('crime_reports');

        // Add a new document to the collection
        await reports.add({
          'report_text': reportText,
          'timestamp': FieldValue.serverTimestamp(), // Get the server timestamp
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your report has been submitted anonymously."),
          ),
        );
        _reportController.clear();
      } catch (e) {
        print("Error submitting report: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to submit report. Please try again."),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please write a report before submitting."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anonymous Reporting"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "You can report any crime scene or suspicious activity here. Your identity will be kept confidential.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _reportController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Enter your anonymous report here, similar to a comment...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.all(16.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Submit Report",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}