import 'package:flutter/material.dart';
// Assuming sos_feature_data.dart is where SOSFeatureItem and sosFeatures are defined
// For this example, I've included them directly above.


class SOSFeatureItem {
  final IconData icon;
  final String name;
  final String description; // Optional: a short description
  final VoidCallback onTap;

  SOSFeatureItem({
    required this.icon,
    required this.name,
    this.description = "",
    required this.onTap,
  });
}

// Placeholder actions - these would trigger actual functionalities
List<SOSFeatureItem> sosFeatures = [
  SOSFeatureItem(
    icon: Icons.phone_forwarded_outlined,
    name: "Helpline Call",
    description: "One-tap call to women’s helpline or police",
    onTap: () => print("Calling Women's Helpline / Police..."),
  ),
  SOSFeatureItem(
    icon: Icons.call_end_outlined, // You might want a different icon for "Emergency Call"
    name: "Emergency Call",
    description: "Preset emergency contact",
    onTap: () => print("Calling Emergency Contact..."),
  ),
  SOSFeatureItem(
    icon: Icons.cloud_upload_outlined,
    name: "Cloud Upload",
    description: "Automatic cloud upload as evidence",
    onTap: () => print("Initiating Cloud Upload..."),
  ),
  SOSFeatureItem(
    icon: Icons.videocam_outlined,
    name: "Record Audio/Video",
    description: "Audio/Video Recording on Trigger",
    onTap: () => print("Starting Audio/Video Recording..."),
  ),
  SOSFeatureItem(
    icon: Icons.phone_callback_outlined,
    name: "Fake Call",
    description: "Simulated incoming call",
    onTap: () => print("Initiating Fake Call..."),
  ),
  // "Trigger without unlocking phone" and "Shake-to-Activate SOS" are activation methods,
  // not typically features on the SOS page itself.
  // "Multiple Activation Options" is a description of how to trigger, not a button on this page.
];



class SOSActivationPage extends StatelessWidget {
  const SOSActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine theme based on context if needed, or define a specific SOS theme
    final Color primaryColor = Colors.red[700]!;
    final Color onPrimaryColor = Colors.white;
    final Color iconBackgroundColor = Colors.red[100]!;
    final Color iconColor = Colors.red[800]!;
    final Color textColor = Colors.grey[800]!;

    return Scaffold(
      backgroundColor: Colors.red[50], // Light red background for urgency
      appBar: AppBar(
        title: Text(
          "EMERGENCY MODE ACTIVATED",
          style: TextStyle(color: onPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // Don't show back button by default
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Select an Action:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.85, // Adjust for content fit
                ),
                itemCount: sosFeatures.length,
                itemBuilder: (context, index) {
                  final feature = sosFeatures[index];
                  return _buildSOSFeatureButton(
                    context: context,
                    item: feature,
                    iconBackgroundColor: iconBackgroundColor,
                    iconColor: iconColor,
                    textColor: textColor,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // TODO: Implement logic to deactivate SOS mode or navigate away
                print("Deactivating SOS Mode / Close Page");
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  // If this is the root, you might need another way to dismiss,
                  // or the trigger mechanism should handle it.
                }
              },
              child: const Text("Cancel / Deactivate SOS", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSFeatureButton({
    required BuildContext context,
    required SOSFeatureItem item,
    required Color iconBackgroundColor,
    required Color iconColor,
    required Color textColor,
  }) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 35, // Adjust size
                backgroundColor: iconBackgroundColor,
                child: Icon(item.icon, size: 30, color: iconColor),
              ),
              const SizedBox(height: 10),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (item.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: textColor.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
