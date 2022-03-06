//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../models/package.dart';
import '../../pages/booking/packageDetailsPage.dart';
import '../../providers/bookings.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';
import '../general/cachedImageWidget.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class PackageContainer extends StatelessWidget {
  final Package? package;
  const PackageContainer(this.package);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (package?.id != null) {
          ShowLoadingDialog(context);
          context
              .read<Bookings>()
              .fetchAndSetPackageDetails(package!.id!)
              .then((response) {
            ShowLoadingDialog(context, dismiss: true);
            if (response.statusCode == 200) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetailsPage(),
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
                    Visibility(
                      visible: package?.isPopular ?? false,
                      child: Container(
                        height: 24,
                        width: 147,
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
                    TitleText(
                      customPadding:
                          const EdgeInsets.only(top: 10.0, bottom: 5.0),
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
        ),
      ),
    );
  }
}
