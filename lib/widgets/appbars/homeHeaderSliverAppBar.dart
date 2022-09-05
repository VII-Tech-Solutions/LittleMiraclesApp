//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';

class HomeHeaderSliverAppBar extends StatelessWidget {
  const HomeHeaderSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAuth = context.read<Auth>().isAuth;
    final helloSection = context.read<AppData>().helloSection;
    final size = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      stretch: false,
      toolbarHeight: 0,
      backgroundColor: Colors.white,
      expandedHeight: helloSection == null || isAuth
          ? 0
          : size.height * 0.7 - kBottomNavigationBarHeight,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          color: helloSection == null || isAuth
              ? Colors.white
              : AppColors.pinkFCE6E3,
          child: helloSection == null || isAuth
              ? Container()
              : Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: helloSection.image ?? '',
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Container(),
                        fadeInDuration: Duration(milliseconds: 50),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 21, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: 'Welcome ',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black45515D,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'to Little\nMiracles by Sherin',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontFamily:
                                          GoogleFonts.manrope().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black45515D,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Check out our photo session packages to get you started',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
