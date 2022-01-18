//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/mainPagesSliverAppBar.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES
import '../../pages/general/splashscreen.dart';

class MoreMainPage extends StatelessWidget {
  const MoreMainPage();

  Widget _buttonWidget(VoidCallback onPressed, String title, String subtitle) {
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
                  _buttonWidget(() {}, 'Your Profile',
                      'Change your account & family’s information'),
                  _buttonWidget(
                      () {}, 'Your Family', 'Change your family information'),
                  _buttonWidget(() {}, 'FAQs', 'Frequently Asked Questions'),
                  _buttonWidget(() {}, 'About Us',
                      'A little bit more about Little Miracles by Sherin'),
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
                                print('instagram');
                              },
                              SocialIconAsset.instagram,
                            ),
                            _socialMediaButton(
                              () {
                                print('facebook');
                              },
                              SocialIconAsset.facebook,
                            ),
                            _socialMediaButton(
                              () {
                                print('snapchat');
                              },
                              SocialIconAsset.snapchat,
                            ),
                            _socialMediaButton(
                              () {
                                print('twitter');
                              },
                              SocialIconAsset.twitter,
                            ),
                            _socialMediaButton(
                              () {
                                print('youtube');
                              },
                              SocialIconAsset.youtube,
                            ),
                            _socialMediaButton(
                              () {
                                print('pinterest');
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButtonWidget(
                  onPress: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Splashscreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  type: ButtonType.generalGrey,
                  title: 'Log out',
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
