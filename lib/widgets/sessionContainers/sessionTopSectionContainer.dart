//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../providers/appData.dart';
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSION

class SessionTopSectionContainer extends StatelessWidget {
  const SessionTopSectionContainer();

  @override
  Widget build(BuildContext context) {
    final package = context.watch<AppData>().package;
    final session = context.watch<AppData>().session;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CachedImageWidget(
            session?.featuredImage ?? '',
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
          padding: const EdgeInsets.all(16),
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
                customPadding: const EdgeInsets.only(bottom: 5.0),
                title: package?.tag ?? '',
                type: TitleTextType.subContainerMainTitle,
              ),
              Visibility(
                visible: session?.subSessionsIds == null,
                child: TitleText(
                  customPadding: const EdgeInsets.all(0),
                  title: session?.date.toString().toSlashddMMMyyyy() ?? '',
                  type: TitleTextType.subContainerMainTitle,
                  weight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
