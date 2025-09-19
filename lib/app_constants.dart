import 'package:flutter/material.dart';

/// A class to hold all the constant values for the application.
/// This helps in maintaining consistency and makes it easy to update
/// values from a single location.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // --- COLORS ---
  static const Color brandColor = Color.fromARGB(255, 255, 205, 243);
  static const Color lightPinkBackground = Color(0xFFFFE4E9);
  static const Color darkPinkText = Color(0xFF880E4F);
  static const Color sosRed = Color(0xFFD32F2F);

  // --- DIMENSIONS & SPACINGS ---
  static const double verticalSpacing = 24.0;
  static const double fieldSpacing = 16.0;

  // --- IMAGE & ASSET PATHS ---
  static const String logoPath = 'assets/images/logo.jpg';
}
