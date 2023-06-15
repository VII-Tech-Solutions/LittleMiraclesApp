//PACKAGES

// Dart imports:
import 'dart:io' show Platform;
import 'dart:math';

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/admin/adminBookingPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/photographerPage.dart';
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
import '../../providers/bookings.dart';
import '../../providers/giftingProvider.dart';
import '../../widgets/buttons/buttonWithIconWidget.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/texts/titleText.dart';
import '../photographer/photographerPage.dart';
import 'admin/photograher.dart';

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

    if (socialType != SSOType.snapchat) {
      ShowLoadingDialog(context);
    }

    switch (socialType) {
      case SSOType.google:
        {
          result = await authProvider.signInWithGoogle();
          // ShowLoadingDialog(context, dismiss: true);
        }
        break;
      case SSOType.facebook:
        {
          result = await authProvider.signInWithFacebook();
          // ShowLoadingDialog(context, dismiss: true);
        }
        break;
      case SSOType.snapchat:
        {
          result = await authProvider.signInWithSnapchat().timeout(
            Duration(seconds: Timeout.value),
            onTimeout: () {
              return null;
            },
          );
          //
        }
        break;
      case SSOType.apple:
        {
          result = await authProvider.signInWithApple();
          // ShowLoadingDialog(context, dismiss: true);
        }
        break;
    }

    //TODO:
//production
    // final token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMmVjMDhhNTI2MjkyMzUwYzFhMGZiYWIxOGEwZjUyMzdjZTc4OWQ1Y2Q4YWUyZTZlMzcwOGUzOGQ2YTE4ZWU2OTQ3YTZkMTk0NzhjNWZlZGIiLCJpYXQiOjE2NzMzNTM3OTksIm5iZiI6MTY3MzM1Mzc5OSwiZXhwIjoxODMxMTIwMTk5LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.VksfxIzbp_UtmXnpS3hYHbQqYJo7rR4-eflzhbzeOQWsm8atfzeZoqsFA47coJnjVlMQ7T0lIbtoMo7XlQgupj3TCl0whHVKrUEsv6sF57HFfC_-TQctzs56NcIqcRqcY3D6ZsL-JZvLFAV5xaZMhm57rzYcrK68OKR6TUZqp3TCvt9HQFm3Z_A0VpZWA73hz6uzTWtEPVPPpQaweOXnL0Y_v6Son3LI5SYVM88FvOoMX6Xq4hWmoV0xYe2Ci4KWY5QMuTUzTjhZN7Umc8sLtPSqBNTV6SltZQJgNuaYWt_hXCDmmAi03B_u1ASkglBej68cG_9GDDnVNWwcXOkW4ATdlHSbIfyH6KneJWyTql32Ayo_qH5Gc3wBeckgGwwhtMD5as1eV54sZSR09bLiXe8m7A8epUphnlEkCScimABwUkMhvhV2OYc6ueHxZGmCSdoUcuRmFhWTF83HIA4-bw3p9CxiblmkQD8eZ7v2RdBG4Sxov9EMpMJ4yWYY4tUcxhC0AI15HJOKLMxarPsFPHs8MQmbHyumy6hqxhh3i6IvsL03IXu_ZSlhLqjsmu3joSF_CQG3SHa3hIh4JVf1CDXlBwSsjs8PFe7iaIochjZkgoD01ODgovL370z-y3hOEIY5WISvNO2cUbF5dJEkVQwFxzUF-y3UEdnwvGtj580';
    //stage
    // final token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzFkZTUzY2ZhMjc0OGNiZTZiZWFlZDQwMzM4M2MwYjRkYTk0N2Q1NTBkMTk4NjMxNzYxMjUwYWJiYjM2ZWQ2YzJjMzBkODQwNTBjZGJkNzciLCJpYXQiOjE2NzYyODQ1MzEsIm5iZiI6MTY3NjI4NDUzMSwiZXhwIjoxODM0MDUwOTMxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.BKKYK088r1RIEiyihAPRnTigJK6F5gn-WBs3t-hMfBTCyu7iaPqTHbsz34UcQb1UBq2EsdDftEOODQvu2gnWph9QjgYNKPVBxwRXP-oD3FUkKRnpLW_RsEuisf34i3JEfllFwllpebnmKjB9Rxe_6ZzNZYhm1zm_-nhbTbJqn0lsH3LWTbW5Q25wgrI2Fd0bbqjhGvVHvSBX9SA-iiUaeoFya59leLGV3kmbQY5lKgjP5uOCtIB3QCEJJX7tut9zPEHj7nu1W1WRWwbUAtuTZWmH2Wlffx_mMi8iy7IahalpW2CIN2qMn6aokCm7cDqd-Upa4GOhXzzOcTGocWbsga13nWp1gS-QS44Je6nNMBeW04_7G0reIC4k2kNUKzIMiaeEl1y_pl-IBkyqVjCd3Dh0HqZtBDySFD3DXXAsbszrGP53XubwkYtM1T79QIPtsBAutcP0rUwos8GILhVg3LEwdI-OVvVdTDSLg3YYIFrFv5_28GpCsk4g39s0k3_wac7INGRARFdZg2O4D-syIM3Q5TpiG2V6oy0z9F06IwD5g9K-GpgwinkYDcv7CDlOqf77moIa2yEfoHQZJkgFQePlQEJqZ4l9-hLd1wOteWJ3ucBsLGIxdlcGKKrV9zbPDkGrDTfcllDcz_nT4Bb6tqh1XSAecp2Zfwukvj51K7k';
    // final token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWE1ZTQ4MjliMTVjMzZkZWFkYmM5YTdlMTQyNjE3NzZhZjc3NGU0ZDY1YjdiMzc1MTE3NzVhM2MxNjkwMjZhMmQyZmU0ODIxOTIyZmNlN2MiLCJpYXQiOjE2NzQzMTg0NTIsIm5iZiI6MTY3NDMxODQ1MiwiZXhwIjoxODMyMDg0ODUyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.DnqJNmCz53iaVOBy8eno1--R68-QQcKYa2ZQx_NkIhNl_DswF3Zy-A0WWDMZK0qgYdIROUlYLAmqL-l5EubNOVJfHUN18Qb9qhilGKMEEtUaBanGuve_ImMJ9YPTI4aJbFdiEl7kjLpNrK-p4f3O6PbUsflsP_vJ6FM2vZ2AH6Ni_2lZQ56rWP7D55cknRU79v0u69x1eRfsYjnXhqTQS8qjGAj6bsH59F6kWOaxCqIWQYki0BIxhl7oYwbWo5JrpQmgt7qZTahqoVQ8EaHQxdccf4CSZBMSxEmKlJxgPOf86eNZ9U9Ks7zrjVKquQ42Hls1ofxwDs2kp-bWlLGCJoHLmcXQlNHx79XKD6f8aJgg4G3DToOdgBg3XFFGbBuy8Y_MaETWLvB2lF3lUNuUh0v8GHqSjx1MihSb-_YHZws8fPSsPbVZMSowOMWzyBS84WoUjrakdwsxE_cOhSgzz1kWmhjQhzE9-TfyQiri_qqqzvu-LvBC0PLoLR-A2B0Hq17KoprkOkn6PTbUhf0F_SmdLWJqTNBb4rfriNmHYVaeodevLaGsMOE1xq8GWCI_A3IT0uGmx5jLKy8WzO9aApsIdEjn2a6Vx1Oi0qy8MWpbcdJcTcv3oTgq5rdPXYEXZL5RRgnWT9cBgudEz0CUxZw41rWZe6-Ojo7jpQRMd0o';
    // await appDataProvider.fetchAndSetSessions(token: token).then((_) {
    //   appDataProvider.fetchAndSetAppData().then((_) {
    //     authProvider.getToken(withNotify: false);
    //     ShowLoadingDialog(context, dismiss: true);
    //     if (authProvider.user?.status == 1) {
    //       authProvider.getToken(withNotify: true);
    //       FirebaseMessaging.instance
    //           .subscribeToTopic('user_${context.read<Auth>().user!.id}');
    //       FirebaseMessaging.instance.subscribeToTopic(
    //           'family_${context.read<Auth>().user!.familyId}');

    //       Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => CustomBottomNavigationBar(),
    //         ),
    //         (Route<dynamic> route) => false,
    //       );
    //     } else {
    //       if (authProvider.user?.role != null && authProvider.user?.role == 2) {
    //         Navigator.pushAndRemoveUntil<void>(
    //           context,
    //           MaterialPageRoute<void>(
    //               builder: (BuildContext context) => const AdminBookingPage()),
    //           ModalRoute.withName('/'),
    //         );
    //       } else if (authProvider.user?.role != null ||
    //           authProvider.user?.role == 1) {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => PhotographersPage(),
    //           ),
    //         );
    //       } else {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => CompleteProfilePage(),
    //           ),
    //         );
    //       }
    //     }
    //   });
    // });

    // Future<void> _firebaseAuth() async {
    //   var credential = EmailAuthProvider.credential(
    //       email: '${_auth.user?.id}@lms.com',
    //       password: generateRandomString(18));
    //   FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    // }

    if (result != null) {
      if (authProvider.token.isNotEmpty) {
        final token = authProvider.token;
        GiftingData giftingProvider =
            Provider.of<GiftingData>(context, listen: false);
        giftingProvider.fetchUserGifts(token);

        final bookingsProvider = context.read<Bookings>();
        bookingsProvider.fetchAdminSessionDetails();
        await appDataProvider.fetchAndSetSessions(token: token).then((_) {
          appDataProvider.fetchAndSetAppData().then((_) {
            authProvider.getToken(withNotify: false);
            ShowLoadingDialog(context, dismiss: true);
            if (authProvider.user?.status == 1) {
              authProvider.getToken(withNotify: true);
              FirebaseMessaging.instance
                  .subscribeToTopic('user_${context.read<Auth>().user!.id}');
              FirebaseMessaging.instance.subscribeToTopic(
                  'family_${context.read<Auth>().user!.familyId}');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
                (Route<dynamic> route) => false,
              );
            } else {
              if (authProvider.user?.role != null &&
                  authProvider.user?.role == 2) {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AdminBookingPage(
                            showChat: true,
                          )),
                  ModalRoute.withName('/'),
                );
              } else if (authProvider.user?.role != null &&
                  authProvider.user?.role == 1) {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const PhotographersPage()),
                  ModalRoute.withName('/'),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompleteProfilePage(),
                  ),
                );
              }
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
                title: 'Sign in to unlock the best of Little Miracles.',
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
                                'https://www.termsfeed.com/live/312c8322-5ff6-4289-9f2f-7d9d77dd620d');
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
                                'https://www.termsfeed.com/live/0915d9b7-e1b7-46e9-b109-8bff28217b57');
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
              // ButtonWithIconWidget(
              //   onPress: () {
              //     _socialLogin(
              //         context, SSOType.facebook, authProvider, appDataProvider);
              //   },
              //   buttonText: 'Login using Facebook',
              //   assetName: 'assets/images/iconsSocialFacebook.svg',
              // ),
              // ButtonWithIconWidget(
              //   onPress: () {
              //     _socialLogin(
              //         context, SSOType.snapchat, authProvider, appDataProvider);

              //     // final val = context.read<Auth>().user?.providerId;

              //     // print(val);

              //     // ShowLoadingDialog(context);
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => CompleteProfilePage(),
              //     //   ),
              //     // );
              //   },
              //   buttonText: 'Login using Snapchat',
              //   assetName: 'assets/images/iconsSocialSnapchat.svg',
              // ),
              Visibility(
                visible: Platform.isIOS,
                child: ButtonWithIconWidget(
                  onPress: () {
                    _socialLogin(
                        context, SSOType.apple, authProvider, appDataProvider);
                  },
                  buttonText: 'Sign in with Apple',
                  assetName: 'assets/images/Shape.svg',
                  type: 'apple',
                ),
              ),
              ButtonWithIconWidget(
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPhotograher(),
                    ),
                  );

                  // _socialLogin(
                  //     context, SSOType.facebook, authProvider, appDataProvider);
                },
                buttonText: 'Login as Admin/photographer',
                assetName: 'assets/images/applogo.png',
                type: 'admin',
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
            ],
          ),
        ],
      ),
    );
  }
}
