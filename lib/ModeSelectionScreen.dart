import 'package:flutter/material.dart';

// Assuming you have a way to define your logo font style,
// possibly from your logo.dart or a theme.
// For simplicity, I'll use a standard TextStyle here.
const TextStyle logoTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 24, // Adjust as per your logo.dart
  // fontFamily: 'YourLogoFontFamily', // If you have a custom font
);

class ModeSelectionScreen extends StatefulWidget {
  const ModeSelectionScreen({super.key});

  @override
  State<ModeSelectionScreen> createState() => _ModeSelectionScreenState();
}

enum AppMode { normal, mother }

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  AppMode? _selectedMode;

  void _selectMode(AppMode mode) {
    setState(() {
      _selectedMode = mode;
    });
    // Add navigation logic or other actions here
    print("Selected mode: $mode");
    if (mode == AppMode.normal) {
      // Navigate to Normal Mode screen or perform action
    } else if (mode == AppMode.mother) {
      // Navigate to Mother Mode screen or perform action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // Light pink background
      appBar: AppBar(
        backgroundColor: Colors.pink[700], // Deep pink background
        title: const Text(
          "Maya",
          style: logoTextStyle,
        ),
        centerTitle: true,
        elevation: 0, // Or a slight shadow if preferred for the AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row( // Or Column for vertical layout
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Or MainAxisAlignment.center and use SizedBox for spacing
            children: <Widget>[
              _buildModeCard(
                icon: Icons.computer,
                label: "Normal Mode",
                mode: AppMode.normal,
                isSelected: _selectedMode == AppMode.normal,
                onTap: () => _selectMode(AppMode.normal),
              ),
              // Add SizedBox(width: 20) here if using Row and need more space
              _buildModeCard(
                // Find a suitable icon for Mother Mode or reuse
                icon: Icons.monitor_heart_outlined, // Example icon
                label: "Mother Mode",
                mode: AppMode.mother,
                isSelected: _selectedMode == AppMode.mother,
                onTap: () => _selectMode(AppMode.mother),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required IconData icon,
    required String label,
    required AppMode mode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: isSelected ? Colors.pink[700]! : Colors.transparent, // Highlight if selected
            width: 2.0,
          ),
        ),
        child: Container(
          width: 150, // Adjust width as needed
          height: 180, // Adjust height as needed
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 60.0, // Adjust icon size
                color: isSelected ? Colors.pink[700] : Colors.grey[700],
              ),
              const SizedBox(height: 15.0),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.pink[700] : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// To use this screen:
// void main() => runApp(MaterialApp(home: ModeSelectionScreen()));