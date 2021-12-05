//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../texts/titleText.dart';
import '../buttons/filledButtonWidget.dart';
import '../buttons/iconButtonWidget.dart';
//PAGES
import '../../pages/login/loginPage.dart';

class LoginSliverAppBar extends StatelessWidget {
  const LoginSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      stretch: false,
      backgroundColor: Colors.white,
      expandedHeight: 175,
      collapsedHeight: 175,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 19, 16, 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(
                    title: 'Hi there ♥️',
                    customPadding: null,
                  ),
                  Row(
                    children: [
                      IconButtonWidget(
                          onPress: () {
                            print('go to cart');
                          },
                          icon: Icons.shopping_cart),
                      SizedBox(width: 16),
                      IconButtonWidget(
                          onPress: () {
                            print('go to chat');
                          },
                          icon: Icons.forum),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 19.5),
                child: Text(
                  'Sign up with us to get the full Little Miracles experience and capture those special moments',
                  style: TextStyle(
                    color: AppColors.black162534,
                  ),
                ),
              ),
              FilledButtonWidget(
                onPress: () {
                  print('go to login');
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
