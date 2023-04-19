// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static Future<bool> confirmActionWithCancel(
    BuildContext context, {
    String? title,
    String? content,
    String confirmText = "Yes",
    String cancelText = "No",
  }) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.ltr,
        child: Platform.isIOS
            ? CupertinoAlertDialog(
                title: title != null ? Text(title) : null,
                content: content != null ? Text(content) : null,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(cancelText),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(confirmText),
                  ),
                ],
              )
            : AlertDialog(
                title: title != null ? Text(title) : null,
                content: content != null ? Text(content) : null,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(cancelText),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(confirmText),
                  ),
                ],
              ),
      ),
    );

    result ??= false;

    return result;
  }
}
