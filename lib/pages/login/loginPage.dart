//PACKAGES
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/buttons/buttonWithIconWidget.dart';
//PAGES

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.pinkF8C0B8.withOpacity(0.0),
                  AppColors.pinkF8C0B8,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  color: AppColors.greyF2F3F3,
                  child: Icon(
                    Icons.clear_rounded,
                    color: AppColors.black45515D,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(8.0),
                  shape: CircleBorder(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      title:
                          'Sign in to unlock the best of Little Miracles by Sherin.',
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 6.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'By proceeding, you agree to our ',
                          style: TextStyle(
                            color: AppColors.black45515D,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Terms of Use ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //todo go to Terms of Use
                                  _launchURL(
                                      'https://www.littlemiraclesbys.com/about/');
                                },
                            ),
                            TextSpan(
                              text: 'and confirm you have read our ',
                            ),
                            TextSpan(
                              text: 'Privacy and Cookie Statement',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //todo go to Privacy and Cookie Statement
                                  _launchURL(
                                      'https://www.littlemiraclesbys.com/faq/');
                                },
                            ),
                            TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    ButtonWithIconWidget(
                      buttonText: 'Login using Google',
                      onPress: () {},
                      assetName: 'assets/images/iconsSocialGoogle.svg',
                    ),
                    ButtonWithIconWidget(
                      buttonText: 'Login using Facebook',
                      onPress: () {},
                      assetName: 'assets/images/iconsSocialFacebook.svg',
                    ),
                    ButtonWithIconWidget(
                      buttonText: 'Login using Snapchat',
                      onPress: () {},
                      assetName: 'assets/images/iconsSocialSnapchat.svg',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
