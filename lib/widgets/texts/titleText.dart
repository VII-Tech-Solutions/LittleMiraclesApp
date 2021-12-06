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
  questionTitle,
}

class TitleText extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? customPadding;
  final TitleTextType? type;
  const TitleText({
    this.title,
    this.customPadding = const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0.0),
    this.type,
  });

  TextStyle? _textStyleBuilder() {
    switch (type) {
      case TitleTextType.mainHomeTitle:
        {
          return TextStyle(
            color: AppColors.black45515D,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          );
        }
      case TitleTextType.questionTitle:
        {
          return TextStyle(
            color: AppColors.black45515D,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );
        }
      default:
        {
          return TextStyle(
            color: AppColors.black45515D,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding ?? EdgeInsets.zero,
      child: Text(
        title ?? '',
        style: _textStyleBuilder(),
      ),
    );
  }
}
