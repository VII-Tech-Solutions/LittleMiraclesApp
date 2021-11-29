//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

enum ButtonType {
  generalWhite,
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
      case ButtonType.generalWhite:
        {
          return AppColors.greyF2F3F3;
        }
      default:
        {
          return null;
        }
    }
  }

  Widget _buildContentWidget() {
    switch (type) {
      case ButtonType.generalWhite:
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
        color: AppColors.black45515D,
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
