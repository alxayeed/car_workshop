import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.labelText,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
