//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import '../../global/colors.dart';

class ButtonWithIconWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String? assetName;
  final String? buttonText;
  final type;
  const ButtonWithIconWidget(
      {@required this.onPress,
      @required this.assetName,
      @required this.buttonText,
      this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          decoration: BoxDecoration(
            color: type == 'admin'
                ? AppColors.blue8DC4CB
                : type == 'apple'
                    ? Colors.black
                    : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (type == 'admin')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      assetName!,
                      fit: BoxFit.cover,
                      height: 34,
                      width: 34,
                    ),
                  )
                else
                  SvgPicture.asset(
                    assetName!,
                    height: type == 'apple' ? 26 : 34,
                    width: type == 'apple' ? 26 : 34,
                  ),
                Text(
                  buttonText ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: type == 'admin' || type == 'apple'
                        ? AppColors.whiteFFFFFF
                        : AppColors.black45515D,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 34,
                  width: 34,
                ),
              ],
            ),
          )),
    );
  }
}
