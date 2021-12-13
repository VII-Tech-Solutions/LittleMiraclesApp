//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/texts/titleText.dart';
//PAGES

class CakePage extends StatefulWidget {
  const CakePage({Key? key}) : super(key: key);

  @override
  _CakePageState createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {
  @override
  Widget build(BuildContext context) {
    final backdrops = context.watch<AppData>().backdrops;

    return Scaffold(
      appBar: AppBarWithBack(
        'Select Cake',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              title: '${backdrops[0].category} Cake',
              type: TitleTextType.subTitleBlack,
              weight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }
}
