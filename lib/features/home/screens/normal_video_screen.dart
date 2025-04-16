import 'package:deepfake/features/home/screens/widgets/custom_confidence_bar.dart';
import 'package:deepfake/features/home/screens/widgets/custom_rounded_confidence_container.dart';
import 'package:deepfake/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/analyzing_provider.dart';

class NormalVideoScreen extends StatefulWidget {
  const NormalVideoScreen({super.key});

  @override
  State<NormalVideoScreen> createState() => _NormalVideoScreenState();
}

class _NormalVideoScreenState extends State<NormalVideoScreen> {
  bool showMoreDetails = false;

  @override
  Widget build(BuildContext context) {

    final lipConfidence = context.read<AnalyzingProvider>().lipConfidence ?? 0.0;
    final eyeConfidence = context.read<AnalyzingProvider>().eyeConfidence ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/real_video_icon.png',
                fit: BoxFit.cover,
              ),
              CustomConfidenceBar(confidence: lipConfidence),

              SizedBox(height: 20.h),

              InkWell(
                onTap: () {
                  setState(() {
                    showMoreDetails = !showMoreDetails;
                  });
                },
                child: Text(
                  showMoreDetails ? 'Hide Details' : 'More Details',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.instance.white.withAlpha(100),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              if (showMoreDetails) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundedConfidenceContainer(text: '${lipConfidence.toStringAsFixed(2)}%'),
                    SizedBox(width: 20.w),
                    Column(
                      children: [
                        SizedBox(
                          width: 130.w,
                          child: Text(
                            'Visual lip-sync matches'.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.instance.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundedConfidenceContainer(text: '${eyeConfidence.toStringAsFixed(2)}%'),
                    SizedBox(width: 20.w),
                    Column(
                      children: [
                        SizedBox(
                          width: 130.w,
                          child: Text(
                            'Visual eye-sync matches'.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.instance.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
