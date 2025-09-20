import 'package:flutter/material.dart';

class MentalHealthSupportScreen extends StatelessWidget {
  const MentalHealthSupportScreen({super.key});

  Widget _buildFeatureListItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7))),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.primaryColor),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color featureIconColor = Colors.pinkAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Health Support"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Your well-being matters. Explore resources to support your mental health during pregnancy.",
              style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),

          _buildFeatureListItem(
            context: context,
            icon: Icons.sentiment_very_satisfied_outlined,
            title: "1. Mood Tracking",
            subtitle: "Daily check-ins & mood trends",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Mood Tracking page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.checklist_rtl_outlined,
            title: "2. Mental Health Assessments",
            subtitle: "Self-evaluation questionnaires (e.g., EPDS)",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Mental Health Assessments page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.self_improvement_outlined,
            title: "3. Guided Meditation & Mindfulness",
            subtitle: "Exercises for pregnancy stress relief",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Guided Meditation page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.lightbulb_outline_rounded,
            title: "4. Coping Strategies & Tips",
            subtitle: "Stress reduction, sleep improvement, journaling",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Coping Strategies page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.menu_book_outlined,
            title: "5. Educational Resources",
            subtitle: "Articles, videos, and podcasts",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Educational Resources page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.groups_outlined,
            title: "6. Community Support",
            subtitle: "Forums and peer support groups",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Community Support page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.medical_services_outlined,
            title: "7. Professional Support Access",
            subtitle: "Directory, teleconsultation, crisis links",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Professional Support Access page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.notifications_active_outlined,
            title: "8. Reminders & Check-ins",
            subtitle: "Nudges for well-being activities",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Reminders & Check-ins page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.nightlight_round_outlined,
            title: "9. Relaxation & Sleep Aids",
            subtitle: "Sounds, soundscapes, sleep tracking",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Relaxation & Sleep Aids page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.monitor_heart_outlined,
            title: "10. Integration With Health Tracking",
            subtitle: "Combine mental & physical health insights",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Integrated Health Tracking page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.campaign_outlined,
            title: "11. Customizable Notifications",
            subtitle: "Positive affirmations, daily tips",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Customizable Notifications page
            },
          ),
          _buildFeatureListItem(
            context: context,
            icon: Icons.crisis_alert_outlined,
            title: "12. Emergency & Crisis Features",
            subtitle: "Quick access for immediate support",
            iconColor: featureIconColor,
            onTap: () {
              // TODO: Add navigation to Emergency & Crisis Features page
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}