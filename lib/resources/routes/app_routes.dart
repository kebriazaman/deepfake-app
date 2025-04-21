import 'package:deepfake/features/auth/screens/login_screen.dart';
import 'package:deepfake/features/auth/screens/signup_screen.dart';
import 'package:deepfake/features/auth/screens/splash_screen.dart';
import 'package:deepfake/resources/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../features/analyzing/screens/analyzing_screen.dart';
import '../../features/analyzing/screens/deepfake_video_screen.dart';
import '../../features/analyzing/screens/normal_video_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case RouteNames.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());


      case RouteNames.deepfakeScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DeepfakeVideoScreen(
            eyeConf: args?['eyeConf'],
            lipConf: args?['lipConf'],
          ),
        );

      case RouteNames.normalScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => NormalVideoScreen(
            eyeConf: args?['eyeConf'],
            lipConf: args?['lipConf'],
          ),
        );

    // Optional: Add a default fallback for `null` route
      case null:
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No screen defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
