//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
//PAGES

class StudioMainTopSectionContainer extends StatelessWidget {
  const StudioMainTopSectionContainer();

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Studio>().studioPackage;
    return Container(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: CachedImageWidget(
              package?.image ?? '',
              ImageShape.square,
              radius: 0.0,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black162534.withOpacity(0.0),
                  AppColors.black162534,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  customPadding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  title: package?.title ?? '',
                  type: TitleTextType.containerMainTitle,
                ),
                TitleText(
                  customPadding: const EdgeInsets.all(0),
                  title: 'Starting from BD ${package?.startingPrice ?? ''}',
                  type: TitleTextType.subContainerMainTitle,
                  weight: FontWeight.w800,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}