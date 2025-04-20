import 'package:deepfake/common/custom_app_button.dart';
import 'package:deepfake/common/custom_textform_field.dart';
import 'package:deepfake/resources/colors/app_colors.dart';
import 'package:deepfake/resources/routes/route_names.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController usernameController, passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/intro_icon.png', fit: BoxFit.cover),
                  Text('TRUESYNC', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.instance.white, fontSize: 30)),
                  SizedBox(height: 10),

                  CustomTextFormField(
                    controller: usernameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: false,
                    validator: (v) => v == null || v.isEmpty ? 'Invalid username' : null,
                  ),

                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    isPasswordVisible: true,
                    validator: (v) => v == null || v.isEmpty ? 'Invalid password' : null,
                  ),

                  const SizedBox(height: 20),

                  Selector<AuthController, bool>(
                    selector: (_, authController) => authController.isLogin,
                    builder: (context, isLoginLoading, _) {
                      return CustomAppButton(
                        title: 'LOGIN',
                        textColor: AppColors.instance.white,
                        backgroundColor: AppColors.instance.buttonBackgroundColor,
                        isLoading: isLoginLoading,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final authController = context.read<AuthController>();
                            final success =
                                await authController.login(context: context, username: usernameController.text.trim(), password: passwordController.text.trim());

                            if (success) {
                              if(!context.mounted) return;
                              Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
                            }
                          }
                        },
                      );
                    },
                  ),

                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.instance.white),
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.instance.white, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, RouteNames.signupScreen);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
