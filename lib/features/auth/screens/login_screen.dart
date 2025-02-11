import 'package:deepfake/common/custom_app_button.dart';
import 'package:deepfake/common/custom_textform_field.dart';
import 'package:deepfake/resources/colors/app_colors.dart';
import 'package:deepfake/resources/routes/route_names.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController, passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
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
                    controller: emailController,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    isPasswordVisible: false,
                    validator: (v) => v == null || v.isEmpty || v != 'admin' ? 'Invalid username' : null,
                  ),

                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    isPasswordVisible: false,
                    validator: (v) => v == null || v.isEmpty || v != 'admin'? 'Invalid password' : null,
                  ),

                  const SizedBox(height: 20),
                  CustomAppButton(
                    title: 'LOGIN',
                    textColor: AppColors.instance.white,
                    backgroundColor: AppColors.instance.buttonBackgroundColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
                      }
                    },
                    // onTap: () => Navigator.pushReplacementNamed(context, RouteNames.homeScreen),
                  ),

                  // Selector<AuthController, bool>(
                  //   selector: (context, authController) => authController.isPasswordToggled,
                  //   builder: (context, isVisible, __) {
                  //     return CustomTextFormField(
                  //       controller: passwordController,
                  //       hintText: 'Password',
                  //       keyboardType: TextInputType.visiblePassword,
                  //       textInputAction: TextInputAction.done,
                  //       onPressed: () => context.read<AuthController>().setPasswordToggled(),
                  //       isPasswordVisible: !context.read<AuthController>().isPasswordToggled,
                  //       // validator: (v) => Utility.validatePassword(v),
                  //       validator: (v) => v == null ? 'Password is required' : null,
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
