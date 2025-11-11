import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "SocialFeed+";

  // Default profile image for dummy user
  static const String defaultProfile =
      'assets/profile_placeholder.png'; //  to assets folder

  // Hive box names
  static const String postsBox = 'posts_box';

  // Mock AI endpoint
  static const String aiMockEndpoint = 'https://dummyjson.com/quotes/random';
}

class AppColors {
  static const Color primary = Colors.blueAccent;
  static const Color secondary = Colors.deepPurpleAccent;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF2C2C2C);
}
