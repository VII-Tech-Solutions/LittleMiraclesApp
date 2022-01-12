//PACKAGES
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
//PAGES

class LoyaltyPage extends StatelessWidget {
  const LoyaltyPage({Key? key}) : super(key: key);

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
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
    );
  }

  Widget _giftContainer({bool isPrevious = false}) {
    return ShaderMask(
      blendMode: isPrevious ? BlendMode.modulate : BlendMode.dst,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.7),
          ],
        ).createShader(bounds);
      },
      child: Container(
        height: 292,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
          color: AppColors.blueE8F3F5,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 177,
              child: CachedImageWidget(
                'https://i.picsum.photos/id/519/500/300.jpg?hmac=83TIFVeExRO0IX7DY_pC9kSeIVFF-hhXAtqQXCSB-os',
                ImageShape.rectangle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  title: 'Mini Session',
                  customPadding: null,
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w800,
                ),
                TitleText(
                  title: 'MINIME123',
                  customPadding: null,
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w600,
                ),
              ],
            ),
            TitleText(
              title: 'Available',
              customPadding: null,
              type: TitleTextType.secondaryTitle,
            ),
            TitleText(
              title: '*This gift is valid until 21/12/2021',
              customPadding: null,
              type: TitleTextType.secondaryTitle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        title: 'Congratulations!',
                        customPadding: const EdgeInsets.only(top: 16),
                      ),
                      TitleText(
                        title:
                            'You have completed 5 sessions with us and this calls for a celebration! 🥳 Please enter the promo code at check out:',
                        customPadding: const EdgeInsets.only(top: 3),
                        type: TitleTextType.secondaryTitle,
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _giftContainer();
                },
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return TitleText(
                    title: 'Previous Gifts',
                    customPadding: const EdgeInsets.only(top: 16),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _giftContainer(isPrevious: true);
                },
                childCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
