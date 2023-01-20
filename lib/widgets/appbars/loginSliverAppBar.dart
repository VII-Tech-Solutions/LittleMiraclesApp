//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// Project imports:
import '../../pages/chat/chat.dart';
import '../../pages/chat/rooms.dart';
import '../dialogs/showLoadingDialog.dart';
import '../../global/colors.dart';
import '../../pages/cart/cartPage.dart';
import '../../pages/login/loginPage.dart';
import '../../providers/auth.dart';
import '../buttons/filledButtonWidget.dart';
import '../buttons/iconButtonWidget.dart';
import '../texts/titleText.dart';

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
      toolbarHeight: isAuth ? 45 : 175,
      expandedHeight: isAuth ? 45 : 175,
      collapsedHeight: isAuth ? 45 : 175,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  if (isAuth)
                    Row(
                      children: [
                        IconButtonWidget(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              );
                            },
                            icon: Icons.shopping_cart),
                        SizedBox(width: 16),
                        IconButtonWidget(
                            onPress: () async {
                              ShowLoadingDialog(context);
                              if (isAuth == true) {
                                //**room chat setup */
                                if (context
                                            .read<Auth>()
                                            .user
                                            ?.chatWithEveryone !=
                                        null &&
                                    context
                                            .read<Auth>()
                                            .user
                                            ?.chatWithEveryone ==
                                        1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RoomsPage(),
                                    ),
                                  ).then((_) => ShowLoadingDialog(context,
                                      dismiss: true));
                                }

                                // **Support only chat setup */
                                // if (await FirebaseAuth
                                //         .instance.currentUser?.uid ==
                                //     'o61U7RotNGb8ICAtjz3mShxsD802') {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => RoomsPage(),
                                //     ),
                                //   ).then((_) =>
                                //       ShowLoadingDialog(context, dismiss: true));
                                // }
                                else {
                                  // final supportRoom =
                                  //     await FirebaseChatCore.instance.createRoom(
                                  //   types.User(
                                  //       id: 'o61U7RotNGb8ICAtjz3mShxsD802'),
                                  // );
                                  //** Multiple support rooms behavior */
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RoomsPage(
                                        canCreateRooms: false,
                                      ),
                                    ),
                                  ).then((value) => ShowLoadingDialog(context,
                                      dismiss: true));
                                  //**Support only chat setup */
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => ChatPage(room: supportRoom),
                                  //   ),
                                  // ).then((value) =>
                                  //     ShowLoadingDialog(context, dismiss: true));
                                }
                              } else {
                                ShowOkDialog(context, 'Please login!',
                                    popToFirst: true);
                              }
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
