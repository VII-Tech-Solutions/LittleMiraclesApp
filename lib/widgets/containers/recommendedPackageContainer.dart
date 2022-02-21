//PACKAGES
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../general/cachedImageWidget.dart';
import '../texts/titleText.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';
//PAGES
import '../../pages/booking/packageDetailsPage.dart';

class RecommendedPackageContainer extends StatelessWidget {
  final Package? package;
  const RecommendedPackageContainer(this.package);

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
        padding: EdgeInsets.only(left: 6),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.64 / 2,
              width: MediaQuery.of(context).size.width * 0.64,
              child: CachedImageWidget(
                package?.image ?? '',
                ImageShape.rectangle,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.64 / 2,
              width: MediaQuery.of(context).size.width * 0.64,
              padding: EdgeInsets.only(left: 16, bottom: 16),
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
                  Text(
                    package?.title ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    package?.tag ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
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
