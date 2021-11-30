//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

Widget mainHomeTitle(BuildContext context, {required String title}) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.only(
      bottom: 20.0,
      top: size.width * 0.045,
    ),
    child: Text(
      '$title',
      style: TextStyle(
        color: AppColors.black45515D,
        fontWeight: FontWeight.w800,
        fontSize: 24.0,
      ),
    ),
  );
}

Widget miniTitle(BuildContext context, {required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      '$title'.toUpperCase(),
      maxLines: 1,
      style: TextStyle(
        color: AppColors.black45515D,
        fontWeight: FontWeight.w200,
        fontSize: 10.0,
        letterSpacing: 1.0,
      ),
    ),
  );
}
