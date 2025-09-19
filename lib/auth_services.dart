import 'dart:async';
import 'package:flutter/foundation.dart';


class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
  });

  // Optional: simple map conversion (not needed if you don’t want it)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}

// --- Custom Exception ---
class AuthServiceException implements Exception {
  final String message;
  final dynamic originalException;

  AuthServiceException(this.message, {this.originalException});

  @override
  String toString() {
    String output = 'AuthServiceException: $message';
    if (originalException != null) {
      output += '\nOriginal Exception: $originalException';
    }
    return output;
  }
}

class AuthService {
  // --- Singleton Pattern ---
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  factory AuthService() => _instance;

  // --- State Management ---
  final StreamController<UserModel?> _userController =
  StreamController<UserModel?>.broadcast();
  Stream<UserModel?> get user => _userController.stream;

  UserModel? _currentUser;

  void _debugLog(String message) {
    debugPrint('[AuthService] $message');
  }

  // --- Initialization ---
  Future<void> initialize() async {
    _debugLog('Initializing AuthService...');
    await Future.delayed(const Duration(milliseconds: 300));
    _updateUser(null);
    _debugLog('AuthService initialized.');
  }

  void _updateUser(UserModel? user) {
    _currentUser = user;
    _userController.add(user);
  }

  UserModel? getCurrentUser() => _currentUser;

  // --- Sign Up ---
  Future<UserModel> signUpWithEmailAndPassword(
      String email,
      String password, {
        String? displayName,
      }) async {
    _debugLog('Attempting to sign up with email: $email');
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (email.isEmpty || password.isEmpty) {
        throw AuthServiceException("Email and password cannot be empty.");
      }
      if (password.length < 6) {
        throw AuthServiceException("Password must be at least 6 characters.");
      }
      if (email == "test@example.com") {
        throw AuthServiceException("Account already exists for this email.");
      }

      final newUser = UserModel(
        uid: "user_${DateTime.now().millisecondsSinceEpoch}",
        email: email,
        displayName: displayName ?? email.split('@').first,
      );

      _debugLog('Signup successful: ${newUser.uid}');
      _updateUser(newUser);
      return newUser;
    } catch (e) {
      if (e is AuthServiceException) rethrow;
      throw AuthServiceException(
        'Unexpected error during signup.',
        originalException: e,
      );
    }
  }

  // --- Login ---
  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    _debugLog('Attempting login for $email');
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (email == "user@example.com" && password == "password123") {
        final user = UserModel(
          uid: "existing_user_123",
          email: email,
          displayName: "Test User",
          photoURL: "https://example.com/avatar.jpg",
        );
        _debugLog('Login successful: ${user.uid}');
        _updateUser(user);
        return user;
      } else {
        throw AuthServiceException("Invalid email or password.");
      }
    } catch (e) {
      if (e is AuthServiceException) rethrow;
      throw AuthServiceException(
        'Unexpected error during login.',
        originalException: e,
      );
    }
  }

  // --- Logout ---
  Future<void> logout() async {
    _debugLog('Logging out user: ${_currentUser?.uid}');
    await Future.delayed(const Duration(milliseconds: 300));
    _updateUser(null);
    _debugLog('Logout successful.');
  }

  // --- Dispose ---
  void dispose() {
    _debugLog('Disposing AuthService.');
    _userController.close();
  }
}
