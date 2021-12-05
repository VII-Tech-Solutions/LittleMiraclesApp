//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class SignupFormTextField extends StatelessWidget {
  final String? title;
  final int? maxLines;
  final double? customWidth;
  final EdgeInsetsGeometry? customMargin;
  const SignupFormTextField({
    @required this.title,
    this.maxLines,
    this.customWidth = double.infinity,
    this.customMargin = const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: customMargin,
      width: customWidth,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 11.0, 16.0, 11.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyD0D3D6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyD0D3D6),
          ),
          hintText: title,
          hintStyle: TextStyle(color: AppColors.greyD0D3D6),
        ),
      ),
    );
  }
}
