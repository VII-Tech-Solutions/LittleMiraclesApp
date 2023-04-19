//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/auth.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import '../../providers/studio.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
import '../../widgets/studioContainers/studioDetailsSectionContainer.dart';
import '../../widgets/studioContainers/studioImageSectionContainer.dart';
import '../../widgets/studioContainers/studioMainTopSectionContainer.dart';
import './studioSpecsSelectorPage.dart';

//EXTENSIONS

class StudioPackageDetailsPage extends StatelessWidget {
  const StudioPackageDetailsPage();

  @override
  Widget build(BuildContext context) {
    final _recommendedBookingList =
        context.watch<AppData>().recommendedBookingList;

    List<Widget> _list = [
      StudioDetailsSectionContainer(),
      StudioImageSectionContainer(),
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 40, bottom: 16),
        child: Text(
          'Recommended Studio Sessions',
          style: TextStyle(
            color: AppColors.black45515D,
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.64 / 2,
              width: MediaQuery.of(context).size.width * 0.64,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 16),
                scrollDirection: Axis.horizontal,
                children: _recommendedBookingList,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FilledButtonWidget(
              onPress: () {
                context.read<Auth>().setSelectedIndex(1);
                Navigator.pop(context);
              },
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              type: ButtonType.generalGrey,
              title: 'See all packages',
            ),
          ),
        ],
      ),
      bottomNavigationBar: StudioBottomSectionContainer(
          canShowEditedPrice: false,
          onTap: () {
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
