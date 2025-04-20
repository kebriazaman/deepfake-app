import 'package:deepfake/common/custom_app_button.dart';
import 'package:deepfake/common/custom_textform_field.dart';
import 'package:deepfake/resources/colors/app_colors.dart';
import 'package:deepfake/resources/routes/route_names.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: usernameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: false,
                    validator: (v) => v == null || v.isEmpty ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: false,
                    validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: true,
                    validator: (v) => v == null || v.length < 6 ? 'Password must be at least 6 characters' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    isPasswordVisible: true,
                    validator: (v) => v != passwordController.text ? 'Passwords do not match' : null,
                  ),
                  const SizedBox(height: 20),


                  Selector<AuthController, bool>(
                    selector: (_, authController) => authController.isSigningUp,
                    builder: (context, isSigningUp, _) {
                      return CustomAppButton(
                        title: 'SIGNUP',
                        textColor: AppColors.instance.white,
                        backgroundColor: AppColors.instance.buttonBackgroundColor,
                        isLoading: isSigningUp,
                        onTap:  () async {
                          if (_formKey.currentState!.validate()) {
                            final authController = context.read<AuthController>();
                            final success = await authController.signup(
                              context: context,
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              confirmPassword: confirmPasswordController.text.trim(),
                            );

                            if (success) {
                              if(!context.mounted) return;
                              Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
                            }
                          }
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.instance.white),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.instance.white,
                                decoration: TextDecoration.underline,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
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
