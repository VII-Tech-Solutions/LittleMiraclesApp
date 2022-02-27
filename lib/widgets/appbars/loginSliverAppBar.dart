//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/pages/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Chat(),
                              ),
                            );
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
