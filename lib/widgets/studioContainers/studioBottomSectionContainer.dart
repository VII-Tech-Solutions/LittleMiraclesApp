//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/studio.dart';
import '../../widgets/general/cachedImageWidget.dart';

class StudioBottomSectionContainer extends StatelessWidget {
  final String? title;
  final String? btnLabel;
  final bool? canShowEditedPrice;
  final bool? showSlectedImages;
  final VoidCallback? onTap;
  const StudioBottomSectionContainer({
    this.title,
    this.btnLabel,
    this.canShowEditedPrice = true,
    this.showSlectedImages = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Studio>().studioPackage;
    final price = context.watch<Studio>().packagePriceWithSpecs;
    final selectedImages = context.watch<Studio>().selectedMedia;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: showSlectedImages == true && selectedImages.length > 0,
          child: Container(
            height: 114,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              //TODO:: add blur to the container
              color: AppColors.greyF2F3F3,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, left: 16),
                  child: Text(
                    '${selectedImages.length} Photo Selected',
                  ),
                ),
                SizedBox(
                  height: 68,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                      height: 68,
                      width: 68,
                      child: CachedImageWidget(
                        selectedImages[index].id,
                        selectedImages[index].url,
                        ImageShape.square,
                        radius: 4,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 2),
                    itemCount: selectedImages.length,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
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
                      price != null && canShowEditedPrice == true
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
        ),
      ],
    );
  }
}
