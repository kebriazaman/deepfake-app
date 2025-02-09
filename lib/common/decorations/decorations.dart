import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/colors/app_colors.dart';
final kFormFieldDecoration = InputDecoration(
  fillColor: AppColors.instance.white,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24.r)),
    borderSide: BorderSide(color: AppColors.instance.darkNavy),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24.4)),
    borderSide: BorderSide(color: AppColors.instance.darkNavy),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24.4)),
    borderSide: BorderSide(color: AppColors.instance.darkNavy),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24.4)),
    borderSide: BorderSide(color: AppColors.instance.darkNavy),
  ),

  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24.4)),
    borderSide: BorderSide(color: AppColors.instance.darkNavy),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
);
