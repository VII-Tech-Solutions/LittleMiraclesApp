//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';

//EXTENSIONS

class AppBarWithClose extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color? color;
  const AppBarWithClose(this.title, this.color);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
        child: Container(
          color: AppColors.whiteFFFFFF,
          height: 1.5,
        ),
        preferredSize: Size.fromHeight(1.0),
      ),
      backgroundColor: color,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: MaterialButton(
          elevation: 0,
          onPressed: () {
            Navigator.maybePop(context);
          },
          color: AppColors.greyF2F3F3,
          child: Icon(
            Icons.close_rounded,
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
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
