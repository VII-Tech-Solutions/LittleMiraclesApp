//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/const.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/packageContainers/packageMainTopSectionContainer.dart';
import '../../widgets/packageContainers/packageDetailsSectionContainer.dart';
import '../../widgets/packageContainers/packageLocationSectionContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/packageContainers/packageRatingSectionContainer.dart';
import '../../widgets/packageContainers/packageImageSectionContainer.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
//PAGES
import '../../pages/booking/bookingSessionPage.dart';
import '../../pages/booking/multiSessionPackage/multiSessionBookingPage.dart';

class PackageDetailsPage extends StatelessWidget {
  const PackageDetailsPage();

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      PackageDetailsSectionContainer(),
      PackageLocationSectionContainer(),
      PackageImageSectionContainer(),
      PackageRatingSectionContainer(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: IconButtonWidget(
              onPress: () {
                Navigator.maybePop(context);
              },
              icon: Icons.arrow_back,
            ),
            stretch: true,
            backgroundColor: Colors.white,
            expandedHeight: 375,
            flexibleSpace: FlexibleSpaceBar(
              background: PackageMainTopSectionContainer(),
              stretchModes: [
                StretchMode.zoomBackground,
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _list[index];
              },
              childCount: _list.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: PackageBottomSectionContainer(onTap: () {
        final package = context.read<Bookings>().package;
        if (package?.type == 1 || package?.type == 3) {
          if (package?.id != null) {
            ShowLoadingDialog(context);
            context
                .read<Bookings>()
                .fetchAndSetAvailableDates()
                .then((response) {
              ShowLoadingDialog(context, dismiss: true);
              if (response.statusCode == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingSessionPage(package),
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
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiSessionBookingPage(),
            ),
          );
        }
      }),
    );
  }
}
