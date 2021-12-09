//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/packageContainers/packageMainTopSectionContainer.dart';
import '../../widgets/packageContainers/packageDetailsSectionContainer.dart';
import '../../widgets/packageContainers/packageLocationSectionContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/packageContainers/packageRatingSectionContainer.dart';
import '../../widgets/packageContainers/packageImageSectionContainer.dart';
//PAGES

class SessionDetailsPage extends StatelessWidget {
  final Package? package;
  const SessionDetailsPage(this.package);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              Navigator.maybePop(context);
            },
            color: AppColors.greyF2F3F3,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.black45515D,
              size: 24,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PackageMainTopSectionContainer(package),
            PackageDetailsSectionContainer(),
            PackageLocationSectionContainer(package),
            PackageImageSectionContainer(package),
            PackageRatingSectionContainer(package),
          ],
        ),
      ),
      bottomNavigationBar: PackageBottomSectionContainer(package),
    );
  }
}
