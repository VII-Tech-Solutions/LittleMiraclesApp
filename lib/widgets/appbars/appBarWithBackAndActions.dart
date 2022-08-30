//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';

class AppBarWithBackAndActions extends StatelessWidget
    with PreferredSizeWidget {
  final String? title;
  final FontWeight? weight;
  final double? elevation;
  final List<Widget> actions;
  const AppBarWithBackAndActions({
    this.title = '',
    this.elevation = 1.0,
    this.weight = FontWeight.w400,
    this.actions = const [],
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0.0,
      shadowColor: AppColors.whiteFFFFFFD9,
      automaticallyImplyLeading: false,
      actions: actions,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: MaterialButton(
          elevation: 0,
          onPressed: () {
            Navigator.maybePop(context);
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