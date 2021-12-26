//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_svg/flutter_svg.dart';
//GLOBAL
import '../global/colors.dart';
//MODELS
//PROVIDERS
import '../providers/auth.dart';
import '../providers/appData.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../widgets/dialogs/showLoadingDialog.dart';
//PAGES

import '../pages/booking/reviewAndPayPage.dart';

class PlayrgoundPage extends StatefulWidget {
  const PlayrgoundPage({Key? key}) : super(key: key);

  @override
  _PlayrgoundPageState createState() => _PlayrgoundPageState();
}

class _PlayrgoundPageState extends State<PlayrgoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          title: 'Playground',
          type: TitleTextType.mainHomeTitle,
        ),
      ),
      body: ListView(
        children: [
        ],
      ),
    );
  }
}
