//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final IconData? icon;
  const IconButtonWidget({
    @required this.onPress,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: AppColors.black45515D,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyF2F3F3,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
