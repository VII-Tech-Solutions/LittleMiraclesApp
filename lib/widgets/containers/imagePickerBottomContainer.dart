//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/filledButtonWidget.dart';

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
