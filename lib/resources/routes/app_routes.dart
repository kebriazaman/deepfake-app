import 'package:deepfake/features/auth/screens/login_screen.dart';
import 'package:deepfake/features/auth/screens/signup_screen.dart';
import 'package:deepfake/features/home/screens/analyzing_screen.dart';
import 'package:deepfake/features/auth/screens/splash_screen.dart';
import 'package:deepfake/features/home/screens/deepfake_video_screen.dart';
import 'package:deepfake/features/home/screens/normal_video_screen.dart';
import 'package:deepfake/resources/routes/route_names.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RouteNames.deepfakeScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => DeepfakeVideoScreen(
            eyeConf: args['eyeConf'],
            lipConf: args['lipConf'],
          ),
        );
      case RouteNames.normalScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => NormalVideoScreen(
          eyeConf: args['eyeConf'],
          lipConf: args['lipConf'],
        ));


      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No Screen defined'),
                  ),
                ));
    }
  }
}
