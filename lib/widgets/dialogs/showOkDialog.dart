// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowOkDialog {
  final BuildContext context;

  final String message;
  final String title;
  final bool popToFirst;
  final bool popWithAction;

  ShowOkDialog(this.context, this.message,
      {this.title = 'Oops',
      this.popToFirst = false,
      this.popWithAction = false}) {
    Theme.of(context).platform == TargetPlatform.iOS
        ? showCupertinoDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () => popToFirst
                      ? Navigator.of(context).popUntil((route) => route.isFirst)
                      : Navigator.of(context).pop(),
                )
              ],
              title: Text(title),
              content: Text(message),
            ),
            barrierDismissible: true,
          ).whenComplete(
            () => popWithAction == true ? Navigator.of(context).pop() : null)
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => popToFirst
                        ? Navigator.of(context)
                            .popUntil((route) => route.isFirst)
                        : Navigator.of(context).pop(),
                    child: Text('OK'))
              ],
            ),
            barrierDismissible: true,
          ).whenComplete(
            () => popWithAction == true ? Navigator.of(context).pop() : null);
  }
}
