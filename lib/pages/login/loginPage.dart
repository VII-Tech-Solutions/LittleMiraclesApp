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
import '../../widgets/buttons/iconButtonWidget.dart';
//PAGES
import '../../pages/login/completeProfilePage.dart';

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
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        shadowColor: Colors.transparent,
        toolbarHeight: 66,
        leadingWidth: 66,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButtonWidget(
              onPress: () {
                Navigator.maybePop(context);
              },
              icon: Icons.close),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/login_bg.png',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.73, 1],
                          colors: [
                            AppColors.pinkF8C0B8.withOpacity(0.0),
                            AppColors.pinkF8C0B8.withOpacity(0.5),
                            AppColors.pinkF8C0B8,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.326,
                color: AppColors.pinkF8C0B8,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompleteProfilePage(),
                    ),
                  );
                },
                buttonText: 'Login using Google',
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
              SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
