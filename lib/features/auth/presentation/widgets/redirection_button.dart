import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/style/app_colors.dart';

class RedirectionButton extends StatelessWidget {
  final String regularText;
  final String linkText;
  final String route;

  const RedirectionButton({
    super.key,
    required this.regularText,
    required this.linkText,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: regularText,
        style: const TextStyle(color: Colors.black), // Regular text style
        children: [
          TextSpan(
            text: linkText,
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
              Get.toNamed(route); // Navigate to the desired route on tap
            },
          ),
        ],
      ),
    );
  }
}
