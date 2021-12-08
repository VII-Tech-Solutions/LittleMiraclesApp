//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class AppBarWithLogo extends StatelessWidget with PreferredSizeWidget {
  const AppBarWithLogo({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blueF4F9FA,
      elevation: 0,
      toolbarHeight: 101,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: AppColors.black45515D,
            size: 24,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      title: Image.asset(
        'assets/images/logoNameColor.png',
        width: MediaQuery.of(context).size.width * 0.555,
      ),
    );
  }
}
