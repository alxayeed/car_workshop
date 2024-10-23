import 'package:car_workshop/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_strings.dart';

int duration = 3;

class SnackbarService {
  static void showSuccessMessage(String message) {
    Get.snackbar(
      AppStrings.success,
      message,
      backgroundColor: AppColors.successBackground,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(8.sp),
      borderRadius: 8.r,
    );
  }

  static void showErrorMessage(String message) {
    Get.snackbar(
      AppStrings.error,
      message,
      backgroundColor: AppColors.errorBackground,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(8.sp),
      borderRadius: 8.r,
    );
  }

  static void showWarningMessage(String message) {
    Get.snackbar(
      AppStrings.warning,
      message,
      backgroundColor: AppColors.warningBackground,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(8.sp),
      borderRadius: 8.r,
    );
  }

  static void showInfoMessage(String message) {
    Get.snackbar(
      AppStrings.info,
      message,
      backgroundColor: AppColors.infoBackground,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(8.sp),
      borderRadius: 8.r,
    );
  }
}
