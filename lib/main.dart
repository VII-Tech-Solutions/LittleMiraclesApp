//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
//GLOBAL
//MODELS
//PROVIDERS
import './providers/auth.dart';
import './providers/appData.dart';
//WIDGETS
//PAGES
import './pages/general/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, AppData>(
          update: (context, auth, previousAppData) => AppData(
            auth.token,
            previousAppData == null ? [] : previousAppData.onboardings,
            previousAppData == null ? [] : previousAppData.dailyTips,
            previousAppData == null ? [] : previousAppData.promotions,
            previousAppData == null ? [] : previousAppData.workshops,
            previousAppData == null ? [] : previousAppData.sections,
          ),
          create: (context) => AppData("", [], [], [], [], []),
        ),
      ],
      child: MaterialApp(
        title: 'Little Miracles',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme(
            Theme.of(context).textTheme,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
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
        home: Splashscreen(),
      ),
    );
  }
}
