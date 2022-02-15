//PACKAGES
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class giftDialog {
  final BuildContext context;

  giftDialog(this.context) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.red,
      content: new Container(
        height: 351,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [],
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
