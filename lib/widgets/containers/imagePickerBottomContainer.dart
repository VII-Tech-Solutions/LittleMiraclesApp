//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class ImagePickerBottomContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final int? count;
  const ImagePickerBottomContainer({
    this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Color(0xccf5f5f5),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$count Photos Selected',
            style: TextStyle(
              color: AppColors.black45515D,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          FilledButtonWidget(
            customWidth: 128,
            onPress: onTap,
            type: ButtonType.generalBlue,
            title: 'Confirm',
          ),
        ],
      ),
    );
  }
}
