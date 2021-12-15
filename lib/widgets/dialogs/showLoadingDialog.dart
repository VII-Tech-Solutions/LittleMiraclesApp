//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class ShowLoadingDialog {
  final BuildContext context;
  bool dismiss;

  ShowLoadingDialog(this.context, {this.dismiss = false}) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            padding: EdgeInsetsDirectional.all(15),
            decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)),
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [Colors.black],
              strokeWidth: 6.0,
            ),
          ),
        ],
      ),
    );
    if (dismiss) {
      Navigator.pop(context);
    } else {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
