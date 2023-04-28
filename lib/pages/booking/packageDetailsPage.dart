//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/booking/photographerPage.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/const.dart';
import '../../pages/booking/multiSessionPackage/multiSessionBookingPage.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
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
              children: [
                PackageDetailsSectionContainer(),
                PackageLocationSectionContainer(),
                PackageImageSectionContainer(),
                PackageRatingSectionContainer(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: PackageBottomSectionContainer(onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PhotographerPage(),
        //   ),
        // );
        final package = context.read<Bookings>().package;

        // ShowLoadingDialog(context);
        // context.read<Bookings>().fetchAndSetAvailableDates().then((response) {
        //   ShowLoadingDialog(context, dismiss: true);
        //   if (response?.statusCode == 200) {
        if (package?.type == PackageType.normalSession ||
            package?.type == PackageType.miniSession) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotographerPage(),
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
        //   } else {
        //     ShowOkDialog(
        //       context,
        //       response?.message ?? ErrorMessages.somethingWrong,
        //     );
        //   }
        // });
      }),
    );
  }
}
