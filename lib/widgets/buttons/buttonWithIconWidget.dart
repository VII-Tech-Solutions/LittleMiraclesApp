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
  const ButtonWithIconWidget({
    @required this.onPress,
    @required this.assetName,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  assetName!,
                  height: 34,
                  width: 34,
                ),
                Text(
                  buttonText ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black45515D,
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
