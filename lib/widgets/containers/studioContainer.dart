//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/studioPackage.dart';
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../general/cachedImageWidget.dart';
import '../texts/titleText.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';
//PAGES
import '../../pages/studio/studioPackageDetailsPage.dart';

class StudioContainer extends StatelessWidget {
  final StudioPackage? package;
  const StudioContainer(this.package);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (package?.id != null) {
          ShowLoadingDialog(context);
          context
              .read<Studio>()
              .fetchAndSetPackageDetails(package!.id!)
              .then((response) {
            ShowLoadingDialog(context, dismiss: true);
            if (response.statusCode == 200) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudioPackageDetailsPage(),
                ),
              );
            } else {
              ShowOkDialog(
                context,
                response.message ?? ErrorMessages.somethingWrong,
              );
            }
          });
        }
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: CachedImageWidget(
                  package?.image ?? '',
                  ImageShape.rectangle,
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(30),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      customPadding: const EdgeInsets.only(bottom: 5.0),
                      title: package?.title ?? '',
                      type: TitleTextType.containerMainTitle,
                    ),
                    TitleText(
                      customPadding: null,
                      title:
                          'Starting from BHD ${package?.startingPrice ?? ''}',
                      type: TitleTextType.subContainerMainTitle,
                      weight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
