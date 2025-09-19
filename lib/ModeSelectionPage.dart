import 'package:flutter/material.dart';
// You might want to navigate to a different page after mode selection.
// For example: import 'package:untitled/HomePage.dart';

class ModeSelectionPage extends StatelessWidget {
  const ModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your brand color for easy reuse
    const Color brandColor = Color(0xFFE91E63); // Example Pink color

    // Define a consistent spacing
    const double verticalSpacing = 32.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFE4E9), // Light pink background
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Big Bold "Select Mode" Text
                const Text(
                  "Select Mode",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'Poppins', // Make sure this font is in your pubspec.yaml
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: verticalSpacing),

                // Use a Row to place cards side-by-side
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Normal Mode Card
                    _ModeCard(
                      title: "Normal mode",
                      icon: Icons.person_outline,
                      color: Colors.blue.shade300,
                      onTap: () {
                        print("Normal mode selected");
                        // TODO: Navigate to the normal mode home screen
                        // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GlobalFeaturesPage()));
                      },
                    ),
                    const SizedBox(width: 20),

                    // Mother Mode Card
                    _ModeCard(
                      title: "Mother mode",
                      icon: Icons.pregnant_woman_outlined,
                      color: brandColor,
                      onTap: () {
                        print("Mother mode selected");
                        // TODO: Navigate to the mother mode home screen
                        // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MotherModeFeaturesPage()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: verticalSpacing * 1.5),

                // Helper text at the bottom
                const Text(
                  "You can change the mode anytime",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A reusable widget for the mode selection cards.
class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 140, // Give cards a fixed width
          height: 180, // Give cards a fixed height
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: color),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
