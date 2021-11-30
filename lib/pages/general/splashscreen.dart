//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/general/loadingIndicator.dart';
//PAGES
import './onboardingPage.dart';
import './customBottomNavigationBar.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final authProvider = context.read<Auth>();
      final appDataProvider = context.read<AppData>();

      appDataProvider.fetchAndSetAppData().then((_) {
        authProvider.getToken().then((_) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => authProvider.isFirstOpen
                    ? OnboardingPage()
                    : CustomBottomNavigationBar(),
              ));
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
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
