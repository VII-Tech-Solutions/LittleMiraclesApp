//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//GLOBAL
//MODELS
//PROVIDERS
import './providers/auth.dart';
import './providers/appData.dart';
import './providers/bookings.dart';
import './providers/studio.dart';
//WIDGETS
//PAGES
import './pages/general/splashscreen.dart';
import 'store/AppStore.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'LMP',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialize();
  FirebaseChatCore.instance.setConfig(
    FirebaseChatCoreConfig('LMP', 'rooms', 'users'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, AppData>(
          update: (context, auth, previousAppData) => AppData(
            auth.token,
            previousAppData == null ? null : previousAppData.session,
            previousAppData == null ? null : previousAppData.package,
            previousAppData == null ? [] : previousAppData.sessions,
            previousAppData == null ? [] : previousAppData.sessionMedia,
            previousAppData == null ? [] : previousAppData.subSessions,
            previousAppData == null ? [] : previousAppData.onboardings,
            previousAppData == null ? [] : previousAppData.dailyTips,
            previousAppData == null ? [] : previousAppData.promotions,
            previousAppData == null ? [] : previousAppData.workshops,
            previousAppData == null ? [] : previousAppData.sections,
            previousAppData == null ? [] : previousAppData.sessionWidgetsList,
            previousAppData == null ? [] : previousAppData.homeList,
            previousAppData == null ? [] : previousAppData.bookingList,
            previousAppData == null
                ? []
                : previousAppData.recommendedBookingList,
            previousAppData == null ? [] : previousAppData.studioList,
            previousAppData == null ? [] : previousAppData.packages,
            previousAppData == null ? [] : previousAppData.backdrops,
            previousAppData == null ? [] : previousAppData.cakes,
            previousAppData == null ? [] : previousAppData.photographers,
            previousAppData == null ? [] : previousAppData.paymentMethods,
            previousAppData == null ? [] : previousAppData.backdropCategories,
            previousAppData == null ? [] : previousAppData.cakeCategories,
            previousAppData == null ? [] : previousAppData.studioPackages,
            previousAppData == null ? [] : previousAppData.studioMetadataList,
            previousAppData == null ? [] : previousAppData.faqsList,
            previousAppData == null ? [] : previousAppData.gifts,
          ),
          create: (context) => AppData(
            "",
            null,
            null,
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Bookings>(
          update: (context, auth, previousBookings) => Bookings(
            auth.token,
            previousBookings == null ? null : previousBookings.package,
            previousBookings == null ? [] : previousBookings.benefits,
            previousBookings == null ? [] : previousBookings.packageMedia,
            previousBookings == null ? [] : previousBookings.packageReviews,
            previousBookings == null ? [] : previousBookings.subPackages,
            previousBookings == null ? [] : previousBookings.selectedBackdrops,
            previousBookings == null ? [] : previousBookings.selectedCakes,
            previousBookings == null
                ? {}
                : previousBookings.subSessionSelectedBackdrops,
            previousBookings == null
                ? {}
                : previousBookings.subSessionSelectedCakes,
            previousBookings == null
                ? {}
                : previousBookings.subSessionSelectedPhotographer,
            previousBookings == null
                ? {}
                : previousBookings.subSessionsTemporaryBooked,
            previousBookings == null ? '' : previousBookings.customBackdrop,
            previousBookings == null ? '' : previousBookings.customCake,
            previousBookings == null ? {} : previousBookings.bookingsBody,
            previousBookings == null ? [] : previousBookings.availableDates,
            previousBookings == null ? [] : previousBookings.availableTimings,
            previousBookings == null ? null : previousBookings.session,
            previousBookings == null ? [] : previousBookings.subSessions,
            previousBookings == null ? null : previousBookings.promoCode,
            previousBookings == null ? [] : previousBookings.feedbackQuestions,
            previousBookings == null ? '' : previousBookings.guidelineString,
          ),
          create: (context) => Bookings('', null, [], [], [], [], [], [], {},
              {}, {}, {}, '', '', {}, [], [], null, [], null, [], ''),
        ),
        ChangeNotifierProxyProvider<Auth, Studio>(
          update: (context, auth, previousStudio) => Studio(
            auth.token,
            previousStudio == null ? [] : previousStudio.benefits,
            previousStudio == null ? [] : previousStudio.packageMedia,
            previousStudio == null ? null : previousStudio.studioPackage,
            previousStudio == null ? null : previousStudio.selectedAlbumSize,
            previousStudio == null ? null : previousStudio.selectedSpreads,
            previousStudio == null ? null : previousStudio.selectedPaperType,
            previousStudio == null ? null : previousStudio.selectedCoverType,
            previousStudio == null ? null : previousStudio.selectedCanvasSize,
            previousStudio == null
                ? null
                : previousStudio.selectedCanvasThickness,
            previousStudio == null ? null : previousStudio.selectedPrintType,
            previousStudio == null
                ? null
                : previousStudio.selectedPhotoPaperSize,
            previousStudio == null ? [] : previousStudio.cartItems,
          ),
          create: (context) => Studio('', [], [], null, null, null, null, null,
              null, null, null, null, []),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: [
          Locale("en"),
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate,
        ],
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
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: Splashscreen(),
      ),
    );
  }
}
