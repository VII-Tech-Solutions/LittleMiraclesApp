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

class PopularPackageContainer extends StatelessWidget {
  final Package? package;
  const PopularPackageContainer(this.package);

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
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 177,
              width: double.infinity,
              child: CachedImageWidget(
                package?.id,
                package?.image,
                ImageShape.rectangle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    package?.title ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'BHD ${package?.price ?? ''}',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                package?.tag ?? '',
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
