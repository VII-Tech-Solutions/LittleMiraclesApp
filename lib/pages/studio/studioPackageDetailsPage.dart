//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/auth.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 16),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1479,
                width: MediaQuery.of(context).size.width * 0.64,
                child: ListView(
                  padding: const EdgeInsets.only(right: 16),
                  scrollDirection: Axis.horizontal,
                  children: _recommendedBookingList,
                ),
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
