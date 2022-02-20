//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
//PAGES

class StudioBottomSectionContainer extends StatelessWidget {
  final String? title;
  final String? btnLabel;
  final VoidCallback? onTap;
  const StudioBottomSectionContainer({
    this.title,
    this.btnLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Studio>().studioPackage;
    final price = context.watch<Studio>().packagePriceWithSpecs;
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
                  title ?? package?.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 18,
                  ),
                ),
                Text(
                  price != null
                      ? 'BD $price'
                      : 'Starting BD ${package?.startingPrice ?? ''}',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.blue8DC4CB,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  btnLabel ?? 'Buy Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
