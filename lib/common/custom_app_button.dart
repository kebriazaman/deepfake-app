import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors/app_colors.dart';
import 'custom_circular_progress_indicator.dart';

class CustomAppButton extends StatelessWidget {
  CustomAppButton({
    required this.title,
    this.onTap,
    required this.textColor,
    required this.backgroundColor,
    this.isLoading = false,
    this.borderColor = Colors.transparent,
    super.key,
  });

  String title;
  VoidCallback? onTap;
  Color backgroundColor;
  Color textColor;
  bool isLoading;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(backgroundColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.r)))),
            fixedSize: WidgetStatePropertyAll(Size(1.sw, 48.h)),
            side: WidgetStatePropertyAll(BorderSide(color: borderColor))),
        child: isLoading
            ? const CustomCircularProgressIndicator()
            : Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
