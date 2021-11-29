import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isCenter;
  LoadingIndicator({this.isCenter = true});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? isCenter
            ? Center(
                child: CupertinoTheme(
                    data: CupertinoTheme.of(context)
                        .copyWith(brightness: Brightness.light),
                    child: CupertinoActivityIndicator(
                      radius: 18,
                    )),
              )
            : CupertinoTheme(
                data: CupertinoTheme.of(context)
                    .copyWith(brightness: Brightness.light),
                child: CupertinoActivityIndicator(
                  radius: 18,
                ))
        : isCenter
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CircularProgressIndicator();
  }
}
