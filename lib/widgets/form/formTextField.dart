//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';

class FormTextFieldWidget extends StatelessWidget {
  final String? title;
  final TextStyle? hintStyle;
  final int? maxLines;
  final double? customWidth;
  final EdgeInsetsGeometry? customMargin;
  final VoidCallback? onTap;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool? emailCheck;
  final bool? optional;

  const FormTextFieldWidget(
      {this.title,
      this.hintStyle = const TextStyle(color: AppColors.greyD0D3D6),
      this.maxLines,
      this.customWidth = double.infinity,
      this.customMargin = const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      this.onTap,
      this.suffixIcon,
      this.inputType = TextInputType.multiline,
      required this.controller,
      this.emailCheck,
      this.optional});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: customMargin,
      width: customWidth,
      color: AppColors.whiteFFFFFF,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 12,
        ),
        onTap: onTap,
        keyboardType: inputType,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (optional != true) {
            if (emailCheck == true) {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

              if (value == null || value.isEmpty) {
                return '';
              }
              if (!emailRegex.hasMatch(value!)) {
                return 'Please enter a valid email address';
              }
            } else {
              if (!title!.contains('Have you ever worked with a')) if (value ==
                      null ||
                  value.isEmpty) {
                return '';
              }
              return null;
            }
            return null;
          }
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          errorStyle: TextStyle(height: 0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyD0D3D6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyD0D3D6),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyD0D3D6),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: title,
          hintStyle: hintStyle,
        ),
      ),
    );
  }
}
