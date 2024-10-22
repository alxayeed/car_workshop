import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/style/app_fonts.dart';
import '../../presentation/controllers/auth_controller.dart';
import '../widgets/redirection_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 250.h),
              Text(
                AppStrings.login,
                style: AppFonts.size32W700,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: emailController,
                hintText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: passwordController,
                hintText: AppStrings.password,
                obscureText: true,
                prefixIcon: Icons.lock,
              ),
              SizedBox(height: 20.h),
              Obx(
                () {
                  return CustomButton(
                    labelText: authController.isLoading.value
                        ? AppStrings.pleaseWait
                        : AppStrings.login,
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                            final String email = emailController.text.trim();
                            final String password =
                                passwordController.text.trim();
                            authController.login(email, password);
                          },
                  );
                },
              ),
              SizedBox(height: 30.h),
              const RedirectionButton(
                regularText: AppStrings.noAccount,
                linkText: AppStrings.signUpLink,
                route: AppRoutes.register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
