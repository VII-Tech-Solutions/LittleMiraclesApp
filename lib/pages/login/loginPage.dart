//PACKAGES

// Dart imports:
import 'dart:io' show Platform;
import 'dart:math';

// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../models/apiResponse.dart';
import '../../pages/general/customBottomNavigationBar.dart';
import '../../pages/login/completeProfilePage.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../widgets/buttons/buttonWithIconWidget.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/texts/titleText.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // String generateRandomString(int uid) {
  //   const _chars =
  //       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\$%&~';
  //   List
  //   for (int i = 0; i < uid; i++) {

  //   }
  //   return List.generate(uid, (index) => _chars[0]).join();
  // }

  // Future<void> saveTokenToDatabase(String token) async {
  //   // Assume user is logged in for this example
  //   String? userId = FirebaseAuth.instance.currentUser?.uid;

  //   await FirebaseFirestore.instance.collection('users').doc(userId).update({
  //     'tokens': FieldValue.arrayUnion([token]),
  //   });
  // }

  // NotificationSettings? _iosSettings;
  // AndroidNotificationChannel? channel;
  // Future<void> _initFCM() async {
  //   // Get the token each time the application loads
  //   String? token = await FirebaseMessaging.instance.getToken();

  //   // Save the initial token to the database
  //   await saveTokenToDatabase(token!);

  //   // Any time the token refreshes, store this in the database too.
  //   FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  //   print(token);
  //   _iosSettings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );

  //   channel = AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     description:
  //         'This channel is used for important notifications.', // description
  //     importance: Importance.max,
  //   );

  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel!);
  // }

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<void> _socialLogin(BuildContext context, String socialType,
      Auth authProvider, AppData appDataProvider) async {
    ApiResponse? result;

    ShowLoadingDialog(context);

    switch (socialType) {
      case SSOType.google:
        {
          result = await authProvider.signInWithGoogle();
        }
        break;
      case SSOType.facebook:
        {
          result = await authProvider.signInWithFacebook();
        }
        break;
      case SSOType.snapchat:
        {
          result = await authProvider.signInWithSnapchat();
          print(result);
        }
        break;
      case SSOType.apple:
        {
          // result = await authProvider.signInWithApple();
        }
        break;
    }

    if (result != null) {
      final user = authProvider.user;

      if (authProvider.token.isNotEmpty) {
        final token = authProvider.token;
        await appDataProvider.fetchAndSetSessions(token: token).then((_) {
          appDataProvider.fetchAndSetAppData().then((_) {
            authProvider.getToken(withNotify: true);
            ShowLoadingDialog(context, dismiss: true);
            if (user?.status == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompleteProfilePage(),
                ),
              );
            }
          });
        });
        // Future<void> _firebaseAuth() async {
        //   var credential = EmailAuthProvider.credential(
        //       email: '${_auth.user?.id}@lms.com',
        //       password: generateRandomString(18));
        //   FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        // }

      } else {
        ShowLoadingDialog(context, dismiss: true);
        ShowOkDialog(context, ErrorMessages.somethingWrong);
      }
    } else {
      ShowLoadingDialog(context, dismiss: true);
      ShowOkDialog(context, ErrorMessages.somethingWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Auth>();
    final appDataProvider = context.watch<AppData>();
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
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 11.0),
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
                  _socialLogin(
                      context, SSOType.google, authProvider, appDataProvider);
                },
                buttonText: 'Login using Google',
                assetName: 'assets/images/iconsSocialGoogle.svg',
              ),
              ButtonWithIconWidget(
                onPress: () {
                  _socialLogin(
                      context, SSOType.facebook, authProvider, appDataProvider);
                },
                buttonText: 'Login using Facebook',
                assetName: 'assets/images/iconsSocialFacebook.svg',
              ),
              ButtonWithIconWidget(
                onPress: () {
                  _socialLogin(
                      context, SSOType.snapchat, authProvider, appDataProvider);

                  // final val = context.read<Auth>().user?.providerId;

                  // print(val);

                  // ShowLoadingDialog(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CompleteProfilePage(),
                  //   ),
                  // );
                },
                buttonText: 'Login using Snapchat',
                assetName: 'assets/images/iconsSocialSnapchat.svg',
              ),
              Visibility(
                visible: Platform.isIOS,
                child: ButtonWithIconWidget(
                  onPress: () {},
                  buttonText: 'Login using Apple',
                  assetName: 'assets/images/iconsSocialApple.svg',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
            ],
          ),
        ],
      ),
    );
  }
}
