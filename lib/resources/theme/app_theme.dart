import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/app_colors.dart';

class AppTheme {


  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.instance.white,
    scaffoldBackgroundColor: AppColors.instance.darkNavy,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.instance.darkNavy,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.instance.white),
      titleTextStyle: TextStyle(
        color: AppColors.instance.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.instance.white,
        foregroundColor: AppColors.instance.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    textTheme:  TextTheme(
      titleLarge: TextStyle(
        color: AppColors.instance.black,
        fontSize: 28.sp,
      ),
      titleMedium: TextStyle(
        color: AppColors.instance.black,
        fontSize: 24,
      ),
      titleSmall: TextStyle(
        color: AppColors.instance.black,
        fontSize: 22,
      ),
      bodyLarge: TextStyle(
        color: AppColors.instance.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.instance.black,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: AppColors.instance.black,
        fontSize: 14,
      ),
    ),

    // Input Decoration Theme (For TextFields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.instance.white24,
      hintStyle: TextStyle(color: AppColors.instance.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),

    // Dropdown Button Theme
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(color: AppColors.instance.white),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.instance.white10),
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColors.instance.white),

  );
}