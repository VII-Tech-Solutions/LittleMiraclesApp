//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/pages/chat.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/chat/chat.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/chat/rooms.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showLoadingDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../texts/titleText.dart';
import '../buttons/filledButtonWidget.dart';
import '../buttons/iconButtonWidget.dart';
//PAGES
import '../../pages/login/loginPage.dart';
import '../../pages/cart/cart.dart';

class LoginSliverAppBar extends StatelessWidget {
  const LoginSliverAppBar();

  @override
  Widget build(BuildContext context) {
    final isAuth = context.read<Auth>().isAuth;
    final user = context.read<Auth>().user;
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      stretch: false,
      backgroundColor: Colors.white,
      expandedHeight: isAuth ? kToolbarHeight : 175,
      collapsedHeight: isAuth ? kToolbarHeight : 175,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 19, 16, 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isAuth
                      ? RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Hi ',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontWeight: FontWeight.w200,
                              color: AppColors.black45515D,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${user?.firstName ?? ''} ✨',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.black45515D,
                                ),
                              ),
                            ],
                          ),
                        )
                      : TitleText(
                          title: 'Hi there ♥️',
                          customPadding: null,
                          type: TitleTextType.mainHomeTitle,
                        ),
                  Row(
                    children: [
                      IconButtonWidget(
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ),
                            );
                          },
                          icon: Icons.shopping_cart),
                      SizedBox(width: 16),
                      IconButtonWidget(
                          onPress: () async {
                            UserCredential? u;
                            ShowLoadingDialog(context);
                            FirebaseAuth auth =
                                FirebaseAuth.instanceFor(app: Firebase.apps[1]);
                            try {
                              u = await auth.createUserWithEmailAndPassword(
                                  email: '${user?.id}@lms.com',
                                  password: '${user!.id! * 5 * 200 + 100000}');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                u = await auth.signInWithEmailAndPassword(
                                    email: '${user?.id}@lms.com',
                                    password:
                                        '${user!.id! * 5 * 200 + 100000}');
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                            await FirebaseChatCore.instance
                                .createUserInFirestore(
                              types.User(
                                firstName: user?.firstName,
                                id: u?.user!.uid ??
                                    '', // UID from Firebase Authentication
                                imageUrl: user?.avatar,
                                lastName: user?.lastName,
                              ),
                            )
                                .then((_) {
                              ShowLoadingDialog(context, dismiss: true);
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoomsPage(),
                                ),
                              );
                            });
                            print('go to chat');
                          },
                          icon: Icons.forum),
                    ],
                  )
                ],
              ),
              Visibility(
                visible: !isAuth,
                child: Padding(
                  padding: const EdgeInsets.only(top: 19.5),
                  child: Text(
                    'Sign up with us to get the full Little Miracles experience and capture those special moments',
                    style: TextStyle(
                      color: AppColors.black162534,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isAuth,
                child: FilledButtonWidget(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  type: ButtonType.generalBlue,
                  title: 'Login',
                  margin: const EdgeInsets.only(top: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
