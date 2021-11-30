//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/loadingIndicator.dart';
//PAGES
import './onboardingPage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    // final authProvider = context.read<Auth>();

    // authProvider.fetchAndSetAppData().then((_) {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => authProvider.isFirstOpen
    //           ? OnboardingPage()
    //           : authProvider.isAuth
    //               ? StudentMainPage()
    //               : LandingPage(),
    //     ));
    // });

    Future.delayed(Duration(seconds: 2)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.whiteF4F9FA,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.541,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.116),
                LoadingIndicator()
              ],
            ),
          )),
    );
  }
}
