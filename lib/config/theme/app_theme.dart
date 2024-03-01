import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient/core/utils/app_colors.dart';
import 'package:patient/core/utils/app_string.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle:
              TextStyle(color: Colors.white, fontFamily: "", fontSize: 17.sp)),
      scaffoldBackgroundColor: AppColors.bg,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      fontFamily: AppString.fontFamily,
    );
  }

  static ThemeData appThemeDark() {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: AppColors.bgDK),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.grey),
      primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
      textTheme: Typography(platform: TargetPlatform.iOS).white,
      scaffoldBackgroundColor: AppColors.bgDK,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryDK,
      fontFamily: AppString.fontFamily,
    );
  }
}
