import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/colors/app_colors.dart';
import 'decorations/decorations.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.controller,
    this.titleTextStyle,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    this.onChange,
    this.readyOnly = false,
    this.suffixIcon,
    this.onTap,
    this.isPasswordVisible = false,
    this.onPressed,
    this.icon,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final TextEditingController? controller;
  final TextStyle? titleTextStyle;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?) validator;
  final Function(String?)? onChange;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  final bool readyOnly;
  final Icon? suffixIcon;
  final bool isPasswordVisible;
  final Icon? icon;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          readOnly: readyOnly,
          obscuringCharacter: '*',
          textCapitalization: textCapitalization,
          obscureText: hintText == 'Password' || hintText == 'Create Password' || hintText == 'Confirm Password'
              ? isPasswordVisible
              : false,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.instance.darkNavy),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: kFormFieldDecoration.copyWith(
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.instance.darkNavy.withAlpha(80)),
            hintText: hintText,
            // suffixIcon:
            //     hintText == 'Password' || hintText == 'Create Password' || hintText == 'Confirm Password'
            //         ? IconButton(
            //             color: AppColors.instance.darkNavy,
            //             onPressed: onPressed, // This should call togglePasswordVisibility
            //             icon: isPasswordVisible
            //                 ? Icon(Icons.visibility, color: AppColors.instance.darkNavy, size: 18.0)
            //                 : Icon(Icons.visibility_off, color: AppColors.instance.darkNavy, size: 18.0),
            //           )
            //         : null,
            prefixIcon: icon,
          ),
          onChanged: onChange,
          onTap: onTap,
        ),
      ],
    );
  }
}
