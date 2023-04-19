//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';

enum TitleTextType {
  mainHomeTitle,
  secondaryTitle,
  containerMainTitle,
  subContainerMainTitle,
  subTitleBlack,
}

class TitleText extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? customPadding;
  final TitleTextType? type;
  final FontWeight weight;
  const TitleText({
    this.title,
    this.customPadding = const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0.0),
    this.type,
    this.weight = FontWeight.w400,
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
      case TitleTextType.secondaryTitle:
        {
          return TextStyle(
            color: AppColors.black45515D,
            fontSize: 14,
            fontWeight: weight,
          );
        }
      case TitleTextType.containerMainTitle:
        {
          return TextStyle(
            color: AppColors.whiteFFFFFF,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          );
        }
      case TitleTextType.subContainerMainTitle:
        {
          return TextStyle(
            color: AppColors.whiteFFFFFF,
            fontSize: 18,
            fontWeight: weight,
          );
        }
      case TitleTextType.subTitleBlack:
        {
          return TextStyle(
            color: AppColors.black45515D,
            fontSize: 18,
            fontWeight: weight,
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
