//PACKAGES
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../../global/colors.dart';
//MODELS
import '../../models/gift.dart';
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
import '../../widgets/dialogs/giftDialog.dart';
//PAGES

class LoyaltyPage extends StatefulWidget {
  const LoyaltyPage();

  @override
  State<LoyaltyPage> createState() => _LoyaltyPageState();
}

class _LoyaltyPageState extends State<LoyaltyPage> {
  String? copiedPromo;

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

  Widget _giftContainer(Gift gift, {bool isPrevious = false}) {
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
                gift.image ?? "",
                ImageShape.rectangle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  title: gift.title,
                  customPadding: null,
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w800,
                ),
                TitleText(
                  title: gift.promoCode,
                  customPadding: null,
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w600,
                ),
              ],
            ),
            TitleText(
              title: isPrevious == false ? 'Available' : 'Claimed',
              customPadding: null,
              type: TitleTextType.secondaryTitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  title:
                      '*This gift is valid until ${gift.validUntil.toString().toSlashddMMMyyyy()}',
                  customPadding: null,
                  type: TitleTextType.secondaryTitle,
                ),
                Visibility(
                  visible: gift.promoCode == copiedPromo,
                  child: Text(
                    'Copied',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w800,
                      color: AppColors.green22D896,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availGifts = context.watch<AppData>().availGifts;
    final prevGifts = context.watch<AppData>().prevGifts;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
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
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => giftDialog(
                            context,
                            availGifts[index].promoCode,
                            availGifts[index].title,
                            availGifts[index]
                                .validUntil
                                .toString()
                                .toSlashddMMMyyyy(),
                            (val) {
                              print(val);
                              setState(() {
                                copiedPromo = val;
                              });
                            },
                          ),
                      child: _giftContainer(availGifts[index]));
                },
                childCount: availGifts.length,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Visibility(
              visible: prevGifts.isNotEmpty,
              child: TitleText(
                title: 'Previous Gifts',
                customPadding: const EdgeInsets.only(top: 16, left: 16),
              ),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   sliver: SliverList(
          //     delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         return TitleText(
          //           title: 'Previous Gifts',
          //           customPadding: const EdgeInsets.only(top: 16),
          //         );
          //       },
          //       childCount: prevGifts.length ,
          //     ),
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _giftContainer(prevGifts[index], isPrevious: true);
                },
                childCount: prevGifts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
