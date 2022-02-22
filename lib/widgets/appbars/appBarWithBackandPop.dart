//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class AppBarWithBackAndPop extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final FontWeight? weight;
  final double? elevation;
  const AppBarWithBackAndPop({
    this.title = '',
    this.elevation = 1.0,
    this.weight = FontWeight.w400,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0.0,
      shadowColor: AppColors.whiteFFFFFFD9,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: MaterialButton(
          elevation: 0,
          onPressed: () {
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 4;
            });
          },
          color: AppColors.greyF2F3F3,
          child: Icon(
            Icons.arrow_back,
            color: AppColors.black45515D,
            size: 24,
          ),
          padding: EdgeInsets.all(8.0),
          shape: CircleBorder(),
        ),
      ),
      title: Text(
        title ?? '',
        style: TextStyle(
          color: AppColors.black45515D,
          fontSize: 18,
          fontWeight: weight,
        ),
      ),
    );
  }
}
