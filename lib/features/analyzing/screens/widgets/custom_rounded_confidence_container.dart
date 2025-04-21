import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRoundedConfidenceContainer extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double padding;

  const CustomRoundedConfidenceContainer({
    super.key,
    required this.text,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 90.w,
        maxHeight: 90.h
      ),
      padding: EdgeInsets.symmetric(horizontal: padding.w, vertical: 8.h),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const StadiumBorder(),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
