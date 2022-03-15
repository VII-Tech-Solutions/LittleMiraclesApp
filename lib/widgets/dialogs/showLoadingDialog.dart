//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/global/const.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:loading_indicator/loading_indicator.dart';

// Project imports:
import '../../global/colors.dart';

//EXTENSIONS

class ShowLoadingDialog {
  final BuildContext context;
  bool dismiss;
  bool withTimeout;
  bool showError;

  ShowLoadingDialog(
    this.context, {
    this.dismiss = false,
    this.withTimeout = false,
    this.showError = false,
  }) {
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
                color: AppColors.greyD4D4D4,
                borderRadius: BorderRadius.circular(15)),
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [Colors.black],
              strokeWidth: 3.0,
            ),
          ),
        ],
      ),
    );
    if (dismiss) {
      Navigator.pop(context);
    } else {
      showDialog(
        barrierDismissible: false, //MARK:: always have it `false`
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      ).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          if (withTimeout == true) {
            Navigator.pop(context);
            if (showError == true) {
              ShowOkDialog(context, ErrorMessages.somethingWrong);
            }
          }
        },
      );
    }
  }
}
