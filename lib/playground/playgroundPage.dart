//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
//GLOBAL
//MODELS
//PROVIDERS
import '../providers/auth.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../widgets/dialogs/showLoadingDialog.dart';
//PAGES
import '../pages/home/homePage.dart';

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
          InkWell(
            onTap: () {
              final val = context.read<Auth>().user?.providerId;

              print(val);
            },
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
          ),
          Icon(IconData(0xe8fd, fontFamily: 'MaterialIcons')),
          FilledButtonWidget(
            onPress: () {
              ShowLoadingDialog(context);
              Timer(Duration(seconds: 3), () {
                // Navigator.pop(context);
                // ShowLoadingDialog(context, dismiss: true);
                // Navigator.push(
                // context,
                // MaterialPageRoute(
                // builder: (context) => HomePage(),
                // ),
                // );
              });
            },
            type: ButtonType.generalBlue,
          )
        ],
      ),
    );
  }
}
