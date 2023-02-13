//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/Global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/chatProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import './pages/general/splashscreen.dart';
import './providers/appData.dart';
import './providers/auth.dart';
import './providers/bookings.dart';
import './providers/studio.dart';
import 'firebase_options.dart';
import 'store/AppStore.dart';
import 'package:LMP0001_LittleMiraclesApp/global/globalHelpers.dart' as global;

AppStore appStore = AppStore();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  print('userid $userId');
  // await FirebaseFirestore.instance.collection('users').doc(userId).update({
  //   'tokens': FieldValue.arrayUnion([token]),
  // });
  // await FirebaseFirestore.instance.collection('users').doc(userId).update({
  //   'tokens': token,
  // });
  print(FirebaseFirestore.instance.app.name);
  await FirebaseFirestore.instance.collection("users").doc(userId).set({
    "tokens": FieldValue.arrayUnion([
      token //Make sure this is Map<String, dynamic> so that firestore can read it
    ])
  }, SetOptions(merge: true));
  print('saved');
}

NotificationSettings? _iosSettings;
late final AndroidNotificationChannel channel;
Future<void> _initFCM() async {
  print("fire token ");
  // Get the token each time the application loads
  String? token = await FirebaseMessaging.instance.getToken();
  Map userData = {
    "firebase_id": FirebaseAuth.instance.currentUser?.uid,
    "device_token ": token
  };
  await Auth().updateProfile(userData);
  Auth().savefiretoken(token);
  print('token $token');
  // // Save the initial token to the database
  await saveTokenToDatabase(token!);

  // // Any time the token refreshes, store this in the database too.
  // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

  _iosSettings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  messaging.subscribeToTopic('lms');
  messaging.subscribeToTopic('staging');
}

FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();

  late final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  _initFCM();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null &&
        android != null &&
        global.roomId != message.data['room_id']) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
            playSound: true,
            enableVibration: true,
            color: AppColors.blue8DC4CB,
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: IOSNotificationDetails(
            presentSound: true,
            presentAlert: true,
            presentBadge: true,
          ),
        ),
      );
    }
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  _initFCM();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await initialize();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://359088e0b05c470aafbe1047151015db@o1397179.ingest.sentry.io/6722505';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _handleMessage(RemoteMessage message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Splashscreen(),
      ),
    );
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

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
            previousBookings == null ? {} : previousBookings.selectedCakes,
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
            previousBookings == null ? false : previousBookings.showAppRateDiag,
          ),
          create: (context) => Bookings('', null, [], [], [], [], [], {}, {},
              {}, {}, {}, '', '', {}, [], [], null, [], null, [], '', false),
        ),
        ChangeNotifierProxyProvider<Auth, Studio>(
          update: (context, auth, previousStudio) => Studio(
            auth.token,
            previousStudio == null ? null : previousStudio.albumTitle,
            previousStudio == null ? null : previousStudio.additionalComment,
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
            previousStudio == null ? '' : previousStudio.cartTotal,
            previousStudio == null ? '' : previousStudio.cartSubtotal,
            // previousStudio == null ? '' : previousStudio.cartDiscount,
          ),
          create: (context) => Studio('', null, null, [], [], null, null, null,
              null, null, null, null, null, null, [], '', ''),
        ),
        ChangeNotifierProvider<ChatData>(
          create: (context) => ChatData({}),
        )
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
