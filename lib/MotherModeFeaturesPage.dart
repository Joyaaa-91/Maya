import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'PregnancyGuideScreen.dart'; // Import the new file

class MotherModeFeaturesPage extends StatefulWidget {
  const MotherModeFeaturesPage({super.key});

  @override
  State<MotherModeFeaturesPage> createState() => _MotherModeFeaturesPageState();
}

class _MotherModeFeaturesPageState extends State<MotherModeFeaturesPage> {
  final String userName = 'Jane';
  String mode = 'Mothermode';
  String greeting = '';
  Color backgroundColor = const Color(0xFFFFE4E6); // Default light pink
  Color textColor = const Color(0xFF880E4F); // Default deep pink

  @override
  void initState() {
    super.initState();
    _setGreetingAndTheme();
  }

  void _setGreetingAndTheme() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = 'Good Morning';
      backgroundColor = const Color(0xFFFFE4E6); // Light pinkish
      textColor = const Color(0xFF880E4F); // Deep pink
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Good Afternoon';
      backgroundColor = const Color(0xFFF06292); // More saturated pink
      textColor = Colors.white;
    } else {
      greeting = 'Good Evening';
      backgroundColor = const Color(0xFFAD1457); // Deep pink
      textColor = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Row(
          children: [
            // Side Navigation Bar
            Container(
              width: 250,
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Maya Icon at the top
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEC407A),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Maya',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const Spacer(),

                  // Radio button group for mode switching
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildModeRadio('Mothermode'),
                      _buildModeRadio('Normal mode'),
                    ],
                  ),
                  const Spacer(),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEEEEEE),
                        foregroundColor: const Color(0xFF424242),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.black12,
                        elevation: 5,
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting Section
                    Text(
                      '$greeting, $userName',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Feature Cards Section
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildFeatureCard(
                          'Doctor Appointment Reminders',
                          const Icon(Icons.calendar_today, color: Colors.pink),
                          onTap: () {
                            // TODO: Add navigation or functionality for Doctor Appointment Reminders
                          },
                        ),
                        _buildFeatureCard(
                          'Pregnancy Diet Plan & Nutrition Tips',
                          const Icon(Icons.restaurant, color: Colors.pink),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PregnancyGuideScreen(),
                              ),
                            );
                          },
                        ),
                        _buildFeatureCard(
                          'Maternity Emergency Button: Calls ambulance or doctor instantly',
                          const Icon(Icons.phone_in_talk, color: Colors.red),
                          onTap: () {
                            // TODO: Add functionality for the Emergency Button
                          },
                        ),
                        _buildFeatureCard(
                          'Mental Health Support: 24/7 helpline and stress relief tips',
                          const Icon(Icons.favorite, color: Colors.pink),
                          onTap: () {
                            // TODO: Add navigation or functionality for Mental Health Support
                          },
                        ),
                        _buildFeatureCard(
                          'Fetal Movement & Contraction Tracker',
                          const Icon(Icons.track_changes, color: Colors.pink),
                          onTap: () {
                            // TODO: Add navigation or functionality for the Tracker
                          },
                        ),
                      ],
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

  Widget _buildModeRadio(String text) {
    return Row(
      children: [
        Radio<String>(
          value: text,
          groupValue: mode,
          onChanged: (value) {
            setState(() {
              mode = value!;
            });
          },
          activeColor: const Color(0xFFEC407A),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF424242),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(String title, Icon icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFCE4EC),
              Color(0xFFF8BBD0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}