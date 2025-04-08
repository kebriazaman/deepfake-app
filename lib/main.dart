import 'package:deepfake/features/home/controllers/analyzing_provider.dart';
import 'package:deepfake/features/auth/controllers/auth_controller.dart';
import 'package:deepfake/repository/analyzing_repository.dart';
import 'package:deepfake/resources/routes/app_routes.dart';
import 'package:deepfake/resources/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => AnalyzingProvider(AnalyzingRepository())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DeepSeek',
            theme: AppTheme.darkTheme,
            onGenerateRoute: AppRoutes.instance.generateRoute,
          );
        },
      ),
    );
  }
}
