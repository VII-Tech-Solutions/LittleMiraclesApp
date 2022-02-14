//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/const.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/studioContainers/studioMainTopSectionContainer.dart';
import '../../widgets/studioContainers/studioDetailsSectionContainer.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
import '../../widgets/studioContainers/studioImageSectionContainer.dart';
//PAGES
import './studioSpecsSelectorPage.dart';

class StudioPackageDetailsPage extends StatelessWidget {
  const StudioPackageDetailsPage();

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      StudioDetailsSectionContainer(),
      StudioImageSectionContainer(),
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
              background: StudioMainTopSectionContainer(),
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
      bottomNavigationBar: StudioBottomSectionContainer(onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudioSpecsSelectorPage(),
          ),
        );
      }),
    );
  }
}
