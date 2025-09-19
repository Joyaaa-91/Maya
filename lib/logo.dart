// lib/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/LoginPage.dart';
import 'package:untitled/app_constants.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  // Use the mixin
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final Duration _splashDuration = const Duration(
    seconds: 3,
  ); // Total duration of splash

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this, // From SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 1500), // Duration of the animation
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack, // A nice bouncy scale effect
      ),
    );

    // Start the animation
    _animationController.forward();

    // Navigate after splash duration
    Timer(_splashDuration, _navigateToLogin);
  }

  void _navigateToLogin() {
    if (mounted) {
      // Check if the widget is still in the tree
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Important to dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCDF3), // Or your desired background color
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,

            child: Image.asset(AppConstants.logoPath),
            // Use your AppLogo widget
          ),
        ),
      ),
    );
  }
}
