import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  // Title styles
  static TextStyle get size32W700 => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700, // Bold
  );

  static TextStyle get size28W600 => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get size24W600 => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  // Body text styles
  static TextStyle get size18W400 => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400, // Normal
    color: Colors.black,
  );

  static TextStyle get size16W400 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  // Caption style
  static TextStyle get size14W400 => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  // Button text style
  static TextStyle get size16W600 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Subtitle styles
  static TextStyle get size16W500 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
