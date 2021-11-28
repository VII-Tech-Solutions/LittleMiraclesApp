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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingPage(),
    );
  }
}
