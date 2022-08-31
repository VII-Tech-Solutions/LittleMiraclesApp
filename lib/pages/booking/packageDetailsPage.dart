//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/const.dart';
import '../../pages/booking/bookingSessionPage.dart';
import '../../pages/booking/multiSessionPackage/multiSessionBookingPage.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/packageContainers/packageDetailsSectionContainer.dart';
import '../../widgets/packageContainers/packageImageSectionContainer.dart';
import '../../widgets/packageContainers/packageLocationSectionContainer.dart';
import '../../widgets/packageContainers/packageMainTopSectionContainer.dart';
import '../../widgets/packageContainers/packageRatingSectionContainer.dart';

//EXTENSIONS

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
          SliverToBoxAdapter(
            child: Column(
              children: _list,
            ),
          ),
        ],
      ),
      bottomNavigationBar: PackageBottomSectionContainer(onTap: () {
        final package = context.read<Bookings>().package;

        ShowLoadingDialog(context);
        context.read<Bookings>().fetchAndSetAvailableDates().then((response) {
          ShowLoadingDialog(context, dismiss: true);
          if (response?.statusCode == 200) {
            if (package?.type == 1 || package?.type == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingSessionPage(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiSessionBookingPage(),
                ),
              );
            }
          } else {
            ShowOkDialog(
              context,
              response?.message ?? ErrorMessages.somethingWrong,
            );
          }
        });
      }),
    );
  }
}
