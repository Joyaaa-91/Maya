import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Make sure you import this
import 'package:untitled/MotherModeFeaturesPage.dart';
import 'package:untitled/logo.dart';
import 'GlobalFeautures.dart';
import 'LoginPage.dart';
import 'firebase_options.dart'; // You need to import this too

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Maya());
}

class Maya extends StatelessWidget {
  const Maya({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maya',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const GlobalFeaturesPage(),
    );
  }
}
