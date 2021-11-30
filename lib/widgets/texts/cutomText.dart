//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

enum CustomTextType {
  mainHomeTitle,
  miniTitle,
}

class CustomText extends StatelessWidget {
  final String? title;
  final CustomTextType? type;
  const CustomText({Key? key, this.title, this.type}) : super(key: key);

  Widget _buildContentWidget() {
    switch (type) {
      case CustomTextType.mainHomeTitle:
        {
          return _mainHomeTitle(title);
        }
      case CustomTextType.miniTitle:
        {
          return _miniTitle(title);
        }
      default:
        {
          return Container();
        }
    }
  }

  Widget _mainHomeTitle(String? text) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.0,
        top: 25.0,
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          color: AppColors.black45515D,
          fontWeight: FontWeight.w800,
          fontSize: 24.0,
        ),
      ),
    );
  }

  Widget _miniTitle(String? text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Text(
        text!.toUpperCase(),
        maxLines: 1,
        style: TextStyle(
          color: AppColors.black45515D,
          fontWeight: FontWeight.w200,
          fontSize: 10.0,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContentWidget();
  }
}
