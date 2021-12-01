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
  final TitleTextType? type;
  const TitleText({Key? key, this.title, this.type}) : super(key: key);

  Widget _buildContentWidget() {
    switch (type) {
      case TitleTextType.mainHomeTitle:
        {
          return _mainHomeTitle(title);
        }
      default:
        {
          return Container();
        }
    }
  }

  Widget _mainHomeTitle(String? text) {
    return Padding(
      // padding: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 10.0),
      padding: EdgeInsets.only(top: 0),
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

  @override
  Widget build(BuildContext context) {
    return _buildContentWidget();
  }
}
