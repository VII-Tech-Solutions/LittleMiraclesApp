//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

enum TitleTextType {
  mainHomeTitle,
}

class TitleText extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? customPadding;
  const TitleText({
    this.title,
    this.customPadding = const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding ?? const EdgeInsets.only(top: 0),
      child: Text(
        title ?? '',
        style: TextStyle(
          color: AppColors.black45515D,
          fontWeight: FontWeight.w800,
          fontSize: 24.0,
        ),
      ),
    );
  }
}
