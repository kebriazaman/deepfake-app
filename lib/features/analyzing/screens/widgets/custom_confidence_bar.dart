import 'dart:developer';

import 'package:deepfake/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomConfidenceBar extends StatelessWidget {
  final double confidence;
  final bool isFake;

  const CustomConfidenceBar({
    super.key,
    required this.confidence,
      this.isFake = false,
  });

  @override
  Widget build(BuildContext context) {
    final double position = isFake
        ? (confidence / 100).clamp(0.0, 1.0)
        : ((100 - confidence) / 100).clamp(0.0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final double barMargin = 12.w;
            final double barHeight = 25.h;
            final double iconSize = 60.sp;
            final double stackHeight = barHeight + (iconSize / 2);
            final double barWidth = constraints.maxWidth - (barMargin * 4);
            final double rawX = barMargin + (position * barWidth) - (iconSize / 2);
            final double arrowX = rawX.clamp(barMargin - (iconSize / 3), barMargin + barWidth - (iconSize / 2)) + 5;
            final double arrowY = (stackHeight - barHeight) / 2.5 - (iconSize / 2);

            return SizedBox(
              height: stackHeight,
              child: Stack(
                children: [
                  // Gradient bar
                  Positioned(
                    top: (stackHeight - barHeight) / 2,
                    left: barMargin,
                    right: barMargin,
                    child: Container(
                      height: barHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.lightBlueAccent, Colors.redAccent],
                        ),
                      ),
                    ),
                  ),
                  // Arrow
                  Positioned(
                    top: arrowY,
                    left: arrowX,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: iconSize,
                      color: AppColors.instance.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("100%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14.sp,
                  )),
              Text("0%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14.sp,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
