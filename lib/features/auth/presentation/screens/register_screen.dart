import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/style/app_fonts.dart'; // Import AppFonts
import '../widgets/custom_text_field.dart';
import '../widgets/redirection_button.dart';
import '../../presentation/controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              // Title
              Text(
                AppStrings.register,
                style: AppFonts.size32W700,
              ),
              SizedBox(height: 20.h),

              // Name TextField
              CustomTextField(
                controller: nameController,
                labelText: AppStrings.name,
                prefixIcon: Icons.person,
              ),

              // Email TextField
              CustomTextField(
                controller: emailController,
                labelText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),

              // Password TextField
              CustomTextField(
                controller: passwordController,
                labelText: AppStrings.password,
                obscureText: true,
                prefixIcon: Icons.lock,
              ),

              SizedBox(height: 20.h),

              // Register Button
              Obx(() {
                return ElevatedButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : () {
                    final String name = nameController.text.trim();
                    final String email = emailController.text.trim();
                    final String password = passwordController.text.trim();
                    authController.register(name, email, password);
                  },
                  child: Text(authController.isLoading.value
                      ? AppStrings.pleaseWait
                      : AppStrings.register),
                );
              }),

              SizedBox(height: 10.h),

              // Redirection Button to Login Screen
              const RedirectionButton(
                regularText: AppStrings.alreadyRegistered,
                linkText: AppStrings.loginLink,
                route: AppRoutes.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
