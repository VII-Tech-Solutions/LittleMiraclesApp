//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/filledButtonWidget.dart';

class PackageBottomSectionContainer extends StatelessWidget {
  final String? btnLabel;
  final VoidCallback? onTap;
  const PackageBottomSectionContainer({
    this.btnLabel = 'Book Now',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    return Container(
      height: 100,
      width: double.infinity,
      color: AppColors.greyF2F3F3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package?.subPackagesIds != null
                      ? package?.title ?? ''
                      : package?.tag ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'BD ${package?.price}',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          FilledButtonWidget(
            customWidth: 128,
            onPress: onTap,
            type: ButtonType.generalBlue,
            title: btnLabel ?? 'Book Now',
          ),
        ],
      ),
    );
  }
}
