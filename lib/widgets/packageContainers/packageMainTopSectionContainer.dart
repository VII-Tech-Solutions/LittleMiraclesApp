//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
//PAGES

class PackageMainTopSectionContainer extends StatelessWidget {
  final Package? package;
  const PackageMainTopSectionContainer(this.package);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 375,
            width: double.infinity,
            child: CachedImageWidget(
              package?.image,
              ImageShape.square,
              radius: 0.0,
            ),
          ),
          Container(
            height: 375,
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
            padding: EdgeInsets.only(
              left: 16,
              top: package?.isPopular == true ? 220 : 245,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: package?.isPopular ?? false,
                  child: Container(
                    height: 24,
                    width: 147,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.orangeFF6B00,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'POPULAR SESSION',
                          style: TextStyle(
                            color: AppColors.whiteFFFFFF,
                            fontSize: 10,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TitleText(
                  customPadding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  title: package?.title ?? '',
                  type: TitleTextType.containerMainTitle,
                ),
                TitleText(
                  customPadding: const EdgeInsets.only(bottom: 5.0),
                  title: package?.tag ?? '',
                  type: TitleTextType.subContainerMainTitle,
                ),
                TitleText(
                  customPadding: const EdgeInsets.all(0),
                  title: 'BD ${package?.price ?? ''}',
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
