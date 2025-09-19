// lib/safety_tips_screen.dart
import 'package:flutter/material.dart';

// --- Data Models (from Step 1, or import if in a separate file) ---
class SafetyTip {
  final String text;
  final String? details;

  SafetyTip({required this.text, this.details});
}

class SafetyCategory {
  final String name;
  final IconData icon;
  final List<SafetyTip> tips;
  final Color? iconColor;

  SafetyCategory({
    required this.name,
    required this.icon,
    required this.tips,
    this.iconColor,
  });
}
// --- End Data Models ---


class SafetyTipsScreen extends StatefulWidget {
  const SafetyTipsScreen({super.key});

  @override
  State<SafetyTipsScreen> createState() => _SafetyTipsScreenState();
}

class _SafetyTipsScreenState extends State<SafetyTipsScreen> {
  // --- Sample Data (Populate with your tips) ---
  final List<SafetyCategory> _safetyCategories = [
    SafetyCategory(
      name: "Personal Safety",
      icon: Icons.person_outline_rounded,
      iconColor: Colors.blue[600],
      tips: [
        SafetyTip(text: "Always share your live location with a trusted contact when traveling alone."),
        SafetyTip(text: "Avoid walking in poorly lit or isolated areas at night."),
        SafetyTip(text: "Trust your instincts. If something feels unsafe, remove yourself from the situation."),
        SafetyTip(text: "Keep your phone fully charged before going out."),
        SafetyTip(text: "Save local emergency numbers (police, ambulance, fire service) for quick access."),
      ],
    ),
    SafetyCategory(
      name: "Digital Safety",
      icon: Icons.phonelink_lock_outlined,
      iconColor: Colors.green[600],
      tips: [
        SafetyTip(text: "Do not share sensitive personal information with strangers online."),
        SafetyTip(text: "Use strong, unique passwords for different accounts and enable two-factor authentication."),
        SafetyTip(text: "Be careful before clicking on suspicious links or downloading unknown apps."),
        SafetyTip(text: "Regularly update your phone’s software and apps for better security patches."),
        SafetyTip(text: "Be mindful of phishing scams via email, SMS, or social media."),
      ],
    ),
    SafetyCategory(
      name: "Travel & Transport Safety",
      icon: Icons.directions_car_filled_outlined,
      iconColor: Colors.orange[700],
      tips: [
        SafetyTip(text: "Verify the driver and vehicle details (number plate, model) before entering a rideshare (e.g., Uber, Pathao)."),
        SafetyTip(text: "Sit in the back seat of rideshares for an extra layer of safety and easier exit."),
        SafetyTip(text: "Share your live trip details with family or friends so they can track your journey."),
        SafetyTip(text: "Avoid displaying valuables openly while in public transport to prevent theft."),
        SafetyTip(text: "Be aware of your surroundings at bus stops, train stations, or while waiting for transport."),
      ],
    ),
    SafetyCategory(
      name: "Home & Daily Life Safety",
      icon: Icons.home_outlined,
      iconColor: Colors.purple[600],
      tips: [
        SafetyTip(text: "Lock your doors and windows properly, even when you are at home or step out briefly."),
        SafetyTip(text: "Keep emergency contacts written down somewhere accessible in case your phone is lost or out of battery."),
        SafetyTip(text: "Inform a family member or close friend about your general daily routine if you live alone."),
        SafetyTip(text: "Don't open the door to strangers without verifying their identity, especially if unexpected."),
        SafetyTip(text: "Have a basic first-aid kit readily available at home."),
      ],
    ),
    SafetyCategory(
      name: "Women’s Specific Safety",
      icon: Icons.woman_2_outlined,
      iconColor: Colors.pinkAccent[400],
      tips: [
        SafetyTip(text: "Carry a whistle, pepper spray (if legal and trained), or personal alarm for deterrence."),
        SafetyTip(text: "Be cautious while accepting food or drinks from strangers, especially in social settings."),
        SafetyTip(text: "In unsafe situations, make noise (shout, use alarm) and try to move towards crowded or well-lit areas to attract attention."),
        SafetyTip(text: "If you feel you are being followed, go to a safe public place (shop, restaurant, police station) and seek help."),
        SafetyTip(text: "Enroll in a basic self-defense class to build confidence and learn practical techniques."),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // This will be your dynamic theme

    return Scaffold(
      appBar: AppBar(
        title: const Text("Safety Tips"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        itemCount: _safetyCategories.length,
        itemBuilder: (context, index) {
          final category = _safetyCategories[index];
          return Card(
            elevation: 2.5,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: (category.iconColor ?? theme.colorScheme.primary).withOpacity(0.15),
                child: Icon(
                  category.icon,
                  color: category.iconColor ?? theme.colorScheme.primary,
                  size: 26,
                ),
              ),
              title: Text(
                category.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: category.iconColor ?? theme.textTheme.titleLarge?.color
                ),
              ),
              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              childrenPadding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 0),
              children: category.tips.map((tip) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 4.0),
                        child: Icon(
                          Icons.check_circle_outline_rounded,
                          size: 20.0,
                          color: category.iconColor?.withOpacity(0.8) ?? theme.colorScheme.primary.withOpacity(0.8),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip.text,
                              style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                            ),
                            if (tip.details != null && tip.details!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  tip.details!,
                                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600], height: 1.3),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}