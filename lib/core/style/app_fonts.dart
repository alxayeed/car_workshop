import 'package:flutter/material.dart';

class AppFonts {
  // Title styles
  static TextStyle get size32W700 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
  );

  static TextStyle get size28W600 => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get size24W600 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Body text styles
  static TextStyle get size18W400 => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400, // Normal
    color: Colors.black,
  );

  static TextStyle get size16W400 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  // Caption style
  static TextStyle get size14W400 => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  // Button text style
  static TextStyle get size16W600 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Subtitle styles
  static TextStyle get size16W500 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
