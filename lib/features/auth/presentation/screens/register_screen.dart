import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.register),
      ),
    );
  }
}
