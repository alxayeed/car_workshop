import 'package:car_workshop/core/constants/app_strings.dart';
import 'package:car_workshop/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
      ),
      body: user == null
          ? const Center(child: Text(AppStrings.noDataAvailable))
          : Center(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100.r,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person,
                        size: 150.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildDetailText(
                        AppStrings.name, user.name, FontAwesomeIcons.user),
                    const Divider(thickness: 1),
                    _buildDetailText(AppStrings.email, user.email,
                        FontAwesomeIcons.envelope),
                    const Divider(thickness: 1),
                    _buildDetailText(AppStrings.role, user.role.name,
                        FontAwesomeIcons.solidUser),
                    const Spacer(),
                    CustomButton(
                      labelText: AppStrings.logout,
                      onPressed: () {
                        authService.clearCurrentUser();
                        Get.offAllNamed('/login');
                      },
                    ),
                    SizedBox(height: 28.h),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDetailText(String title, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          FaIcon(icon, color: AppColors.iconColor),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
