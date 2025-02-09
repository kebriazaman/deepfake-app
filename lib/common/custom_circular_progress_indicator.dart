import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../resources/colors/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({this.color = Colors.white, this.size = 20 ,super.key});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        // size: ScreenUtil.instance.r(size), // Make the size responsive
        size: size.r,
        // size: radius(context, size),
        color: color,
      ),
    );
  }
}
