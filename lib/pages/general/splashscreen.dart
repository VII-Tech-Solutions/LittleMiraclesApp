//PACKAGES

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/providers/studio.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

import '../../providers/giftingProvider.dart';
import './customBottomNavigationBar.dart';
import './onboardingPage.dart';
import '../../global/colors.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';

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
      final authProvider = context.watch<Auth>();
      final appDataProvider = context.read<AppData>();
      final cartItems = context.watch<Studio>();
      var giftingProvider = Provider.of<GiftingData>(context, listen: false);

      authProvider.getToken().then((_) {
        if (authProvider.isAuth) {
          final token = authProvider.token;
          if (authProvider.user!.role != 1 && authProvider.user!.role != 2) {
            giftingProvider.fetchUserGifts(token);
          }
          appDataProvider.fetchAndSetSessions(token: token).then(
                (value) => appDataProvider
                    .fetchAndSetAppData()
                    // .then((_) => cartItems.getCartItemsDB())
                    .then((_) => authProvider.getToken(withNotify: true).then(
                          (_) {
                            Future.delayed(Duration(seconds: 1)).then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => authProvider.isFirstOpen
                                      ? OnboardingPage()
                                      : CustomBottomNavigationBar(),
                                ),
                              ),
                            );
                          },
                        )),
              );
        } else {
          appDataProvider.fetchAndSetAppData().then((_) {
            Future.delayed(Duration(seconds: 1)).then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => authProvider.isFirstOpen
                      ? OnboardingPage()
                      : CustomBottomNavigationBar(),
                ),
              ),
            );
          });
        }
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
        child: Image.asset(
          'assets/images/Splash_Screen.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
