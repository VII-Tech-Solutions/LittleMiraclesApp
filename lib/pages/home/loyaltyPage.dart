//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/colors.dart';
import '../../../global/const.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../../widgets/buttons/iconButtonWidget.dart';
//PAGES

class LoyaltyPage extends StatelessWidget {
  const LoyaltyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
            expandedHeight: 242,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 37),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.yellowFFFBF0,
                      AppColors.yellowFFB400,
                    ],
                  ),
                ),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'We got a special ',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black45515D,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'gift for you 🎁',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black45515D,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              stretchModes: [
                StretchMode.zoomBackground,
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column();
                },
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.yellow,
                  );
                },
                childCount: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
