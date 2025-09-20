import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class EmergencyCallPage extends StatelessWidget {
  const EmergencyCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Calls (Bangladesh)')),
      body: ListView(
        children: const [
          EmergencyListItem(
            icon: Icons.local_police,
            name: 'Police',
            number: '999',
          ),
          EmergencyListItem(
            icon: Icons.local_fire_department,
            name: 'Fire Service',
            number: '102',
          ),
          EmergencyListItem(
            icon: Icons.local_hospital,
            name: 'Ambulance',
            number: '102',
          ),
          EmergencyListItem(
            icon: Icons.phone,
            name: 'National Emergency Service',
            number: '112',
          ),
        ],
      ),
    );
  }
}

class EmergencyListItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String number;

  const EmergencyListItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 32),
                const SizedBox(width: 16),
                Text(name, style: const TextStyle(fontSize: 18)),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () => _launchCall(number),
            ),
          ],
        ),
      ),
    );
  }

  void _launchCall(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
}
