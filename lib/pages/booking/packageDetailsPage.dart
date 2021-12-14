//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/packageContainers/packageMainTopSectionContainer.dart';
import '../../widgets/packageContainers/packageDetailsSectionContainer.dart';
import '../../widgets/packageContainers/packageLocationSectionContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/packageContainers/packageRatingSectionContainer.dart';
import '../../widgets/packageContainers/packageImageSectionContainer.dart';
//PAGES

class PackageDetailsPage extends StatelessWidget {
  final Package? package;
  const PackageDetailsPage(this.package);

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      // PackageMainTopSectionContainer(package),
      PackageDetailsSectionContainer(),
      PackageLocationSectionContainer(package),
      PackageImageSectionContainer(package),
      PackageRatingSectionContainer(package),
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
            title: IconButtonWidget(
              onPress: () {},
              icon: Icons.arrow_back,
            ),
            stretch: true,
            backgroundColor: Colors.white,
            expandedHeight: 375,

            flexibleSpace: FlexibleSpaceBar(
              background: PackageMainTopSectionContainer(package),
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
      bottomNavigationBar: PackageBottomSectionContainer(package),
    );
  }

  Widget _old() {
    return SingleChildScrollView(
      child: Column(
        children: [
          PackageMainTopSectionContainer(package),
          PackageDetailsSectionContainer(),
          PackageLocationSectionContainer(package),
          PackageImageSectionContainer(package),
          PackageRatingSectionContainer(package),
        ],
      ),
    );
  }
}
