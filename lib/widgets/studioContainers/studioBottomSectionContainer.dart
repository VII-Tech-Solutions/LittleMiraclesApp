//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class StudioBottomSectionContainer extends StatelessWidget {
  final String? btnLabel;
  final VoidCallback? onTap;
  const StudioBottomSectionContainer({
    this.btnLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Studio>().studioPackage;
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
                  package?.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Starting BD ${package?.startingPrice ?? ''}',
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
            title: btnLabel ?? 'Buy Now',
          ),
        ],
      ),
    );
  }
}
