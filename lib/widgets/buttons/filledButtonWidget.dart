//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import '../../global/colors.dart';

enum ButtonType {
  generalGrey,
  generalBlue,
  generalPink,
  outlinedYellow,
}

class FilledButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final ButtonType? type;
  final bool isEnabled;
  final String? title;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final String? assetName;
  final double? customWidth;
  final double? height;
  const FilledButtonWidget(
      {@required this.onPress,
      @required this.type,
      this.isEnabled = true,
      this.title,
      this.margin,
      this.icon,
      this.assetName,
      this.customWidth = double.infinity,
      this.height = 48});

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
      case ButtonType.generalPink:
        {
          return AppColors.pinkFCE0DC;
        }
      case ButtonType.outlinedYellow:
        {
          return AppColors.yellowFFF0CC;
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
      case ButtonType.generalPink:
      case ButtonType.outlinedYellow:
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

  Color _buildBorderStyle() {
    switch (type) {
      case ButtonType.outlinedYellow:
        {
          return AppColors.yellowFFB400;
        }
      default:
        {
          return AppColors.transpernt00FFFFFF;
        }
    }
  }

  Widget _buildContentWidget() {
    switch (type) {
      case ButtonType.generalBlue:
      case ButtonType.generalGrey:
      case ButtonType.outlinedYellow:
        {
          return _subBuildTextWidget(title);
        }
      case ButtonType.generalPink:
        {
          return _subBuildTextWithLeftIconWidget(title, assetName!);
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

  Widget _subBuildTextWithLeftIconWidget(String? text, String assetName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 17.0),
          child: Container(
            child: SvgPicture.asset(
              assetName,
            ),
          ),
        ),
        _subBuildTextWidget(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: customWidth,
      child: InkWell(
        onTap: isEnabled ? onPress : null,
        child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _buildButtonStyle(),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _buildBorderStyle(),
            ),
          ),
          child: _buildContentWidget(),
        ),
      ),
    );
  }
}
