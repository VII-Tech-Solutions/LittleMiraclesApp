//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

enum ButtonType {
  generalGrey,
  generalBlue,
}

class FilledButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final ButtonType? type;
  final bool isEnabled;
  final String? title;
  final EdgeInsetsGeometry? margin;
  const FilledButtonWidget({
    @required this.onPress,
    @required this.type,
    this.isEnabled = true,
    this.title,
    this.margin,
  });

  Color? _buildButtonStyle() {
    switch (type) {
      case ButtonType.generalGrey:
        {
          return AppColors.greyF2F3F3;
        }
      case ButtonType.generalBlue:
        {
          return AppColors.blue8DC4CB;
        }
      default:
        {
          return null;
        }
    }
  }

  Color? _buildButtonTextColor() {
    switch (type) {
      case ButtonType.generalGrey:
        {
          return AppColors.black45515D;
        }
      case ButtonType.generalBlue:
        {
          return AppColors.whiteFFFFFF;
        }
      default:
        {
          return null;
        }
    }
  }

  Widget _buildContentWidget() {
    switch (type) {
      case ButtonType.generalBlue:
      case ButtonType.generalGrey:
        {
          return _subBuildTextWidget(title);
        }
      default:
        {
          return Container();
        }
    }
  }

  Widget _subBuildTextWidget(String? text) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: _buildButtonTextColor(),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 48,
      child: InkWell(
        onTap: isEnabled ? onPress : null,
        child: Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _buildButtonStyle(),
            borderRadius: BorderRadius.circular(24),
          ),
          child: _buildContentWidget(),
        ),
      ),
    );
  }
}
