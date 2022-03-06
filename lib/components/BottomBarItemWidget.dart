// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:nb_utils/nb_utils.dart';

// Project imports:
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/Images.dart';

class BottomBarItemWidget extends StatelessWidget {
  final Color? color;
  final Function? onTap;
  final String? title;
  final IconData? icons;
  final bool? isPremium;

  BottomBarItemWidget(
      {this.color, this.onTap, this.title, this.icons, this.isPremium = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() / 6,
      height: 60,
      decoration:
          BoxDecoration(border: Border.all(color: viewLineColor), color: color),
      alignment: Alignment.center,
      child: Material(
        color: Colors.white24,
        child: InkWell(
          onTap: () {
            onTap!.call();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icons, color: Colors.black),
                  4.height,
                  Text(title.validate(),
                          style: boldTextStyle(color: Colors.black, size: 13))
                      .fit(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
