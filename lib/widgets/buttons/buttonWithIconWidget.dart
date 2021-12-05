//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

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
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          width: double.infinity,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.whiteFFFFFF,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 13.0, 60.0, 13.0),
                child: SvgPicture.asset(
                  assetName!,
                ),
              ),
              Text(
                buttonText ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
