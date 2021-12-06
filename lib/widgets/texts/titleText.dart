//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
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
    @required this.type,
  });

  Widget _subBuildTextWidget(String? text, FontWeight weight, double fontSize) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: AppColors.black45515D,
        fontSize: fontSize,
        fontWeight: weight,
      ),
    );
  }

  Widget _buildContentWidget() {
    switch (type) {
      case TitleTextType.mainHomeTitle:
        {
          return _subBuildTextWidget(title, FontWeight.w800, 24);
        }
      case TitleTextType.questionTitle:
        {
          return _subBuildTextWidget(title, FontWeight.w400, 14);
        }
      default:
        {
          return Container();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding ?? const EdgeInsets.only(top: 0),
      child: _buildContentWidget(),
    );
  }
}
