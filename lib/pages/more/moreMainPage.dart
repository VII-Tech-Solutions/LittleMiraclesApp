//PACKAGES

// Flutter imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../pages/general/splashscreen.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/mainPagesSliverAppBar.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import './aboutUsPage.dart';
import './editYourFamilyChoicesPage.dart';
import './editYourProfilePage.dart';
import './faqsPage.dart';

//EXTENSIONS

class MoreMainPage extends StatelessWidget {
  const MoreMainPage();

  _launchURL(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget _buttonWidget(String title, String subtitle, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: 39,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black45515D,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black45515D,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: AppColors.black45515D,
              )
            ],
          )),
    );
  }

  Widget _socialMediaButton(VoidCallback onPress, String asset) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.5),
        child: InkWell(
          onTap: onPress,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: asset.contains('png')
                ? Image.asset(
                    asset,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : SvgPicture.asset(
                    asset,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),
        ),
      ),
    );
  }

  bool _isAuthenticated(BuildContext context) {
    final isAuth = context.read<Auth>().isAuth;

    if (isAuth == false) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Please Login!'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return isAuth;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        MainPagesSliverAppBar('More', 'Settings ⚙️'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  _buttonWidget(
                    'Your Profile',
                    'Change your account & family’s information',
                    () {
                      if (_isAuthenticated(context)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditYourProfilePage(),
                          ),
                        );
                      }
                    },
                  ),
                  _buttonWidget(
                    'Your Family',
                    'Change your family information',
                    () {
                      if (_isAuthenticated(context)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditYourFamilyChoicesPage(),
                          ),
                        );
                      }
                    },
                  ),
                  _buttonWidget(
                    'FAQs',
                    'Frequently Asked Questions',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQsPage(),
                        ),
                      );
                    },
                  ),
                  _buttonWidget(
                    'About Us',
                    'A little bit more about Little Miracles by Sherin',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUsPage(),
                        ),
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                        child: Text(
                          'Follow our Social Media',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black45515D,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.5, vertical: 6),
                        child: Row(
                          children: [
                            _socialMediaButton(
                              () {
                                _launchURL(
                                    'https://www.instagram.com/littlemiraclesbys/');
                              },
                              SocialIconAsset.instagram,
                            ),
                            _socialMediaButton(
                              () {
                                _launchURL(
                                    'https://www.facebook.com/littlemiraclesbys/');
                              },
                              SocialIconAsset.facebook,
                            ),
                            _socialMediaButton(
                              () {
                                _launchURL(
                                    'https://www.snapchat.com/add/little.miracles');
                              },
                              SocialIconAsset.snapchat,
                            ),
                            _socialMediaButton(
                              () {
                                _launchURL(
                                    'https://twitter.com/littlemiracless');
                              },
                              SocialIconAsset.twitter,
                            ),
                            _socialMediaButton(
                              () {
                                _launchURL(
                                    'https://www.youtube.com/channel/UCK2M5iUpBDotM7qO329GHHQ');
                              },
                              SocialIconAsset.youtube,
                            ),
                            _socialMediaButton(
                              () {
                                _launchURL(
                                    'https://www.pinterest.com/littlemiraclesbys/');
                              },
                              SocialIconAsset.pinterest,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            },
            childCount: 1,
          ),
        ),
        SliverFillRemaining(
          fillOverscroll: false,
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Visibility(
              visible: context.read<Auth>().isAuth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButtonWidget(
                    onPress: () {
                      context.read<AppData>().clearUserData().then(
                            (_) => context.read<Auth>().logout().then(
                              (_) {
                                FirebaseAuth.instance.signOut();
                                FirebaseMessaging.instance.unsubscribeFromTopic(
                                    'user_${context.read<Auth>().user!.id}');
                                FirebaseMessaging.instance.unsubscribeFromTopic(
                                    'family_${context.read<Auth>().user!.familyId}');
                                return Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Splashscreen(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          );
                    },
                    type: ButtonType.generalGrey,
                    title: 'Log out',
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
