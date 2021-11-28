//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES
import './pages/general/onboardingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Miracles',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Manrope',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // scaffoldBackgroundColor: AppColors.lightBlueF3F8F9,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.white,
            //todo: implement it later
            // titleTextStyle: TextStyle(
            //   color: AppColors.blue00586F,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
      home: OnboardingPage(),
    );
  }
}
