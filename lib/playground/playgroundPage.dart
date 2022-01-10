//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/pages/login/childrenPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/login/familyPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../extensions/stringExtension.dart';
//GLOBAL
import '../global/colors.dart';
//MODELS
import '../models/package.dart';
import '../../../models/question.dart';
//PROVIDERS
import '../providers/auth.dart';
import '../providers/appData.dart';
import '../providers/bookings.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/texts/titleText.dart';
import '../../../widgets/form/textQuestionWidget.dart';
//PAGES

class PlayrgoundPage extends StatefulWidget {
  const PlayrgoundPage({Key? key}) : super(key: key);

  @override
  _PlayrgoundPageState createState() => _PlayrgoundPageState();
}

class _PlayrgoundPageState extends State<PlayrgoundPage> {
  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.read<Bookings>();
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
                final list = [1,2,3,4,5];

                
              },
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.red,
              ),
            )
          ],
        ));
  }
}
