//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/texts/titleText.dart';
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES

class SessionContainer extends StatelessWidget {
  final bool isVisibile;
  const SessionContainer(this.isVisibile);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              height: 343,
              width: double.infinity,
              child: CachedImageWidget(
                'assets/images/splash_background.png',
                ImageShape.rectangle,
              ),
            ),
            Container(
              height: 343,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
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
              padding: const EdgeInsets.only(left: 30, top: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isVisibile,
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
                    customPadding:
                        const EdgeInsets.only(top: 10.0, bottom: 5.0),
                    title: 'Twinkle',
                    type: TitleTextType.containerMainTitle,
                  ),
                  TitleText(
                    customPadding: const EdgeInsets.only(bottom: 5.0),
                    title: 'Portrait Studio Session',
                    type: TitleTextType.subContainerMainTitle,
                  ),
                  TitleText(
                    customPadding: const EdgeInsets.only(bottom: 30.0),
                    title: 'BD 160',
                    type: TitleTextType.subContainerMainTitle,
                    weight: FontWeight.w800,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
