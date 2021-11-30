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

    // Future.delayed(Duration(seconds: 2)).then(
    //   (value) => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => OnboardingPage(),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.whiteF4F9FA,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                'assets/images/splash_background.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.39,
                child: LoadingIndicator(),
              )
            ],
          )),
    );
  }
}
