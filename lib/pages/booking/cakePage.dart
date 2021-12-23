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
import '../../widgets/bookingSessonContainers/selectionRow.dart';
//PAGES

class CakePage extends StatefulWidget {
  const CakePage({Key? key}) : super(key: key);

  @override
  _CakePageState createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {
  @override
  Widget build(BuildContext context) {
    final cakes = context.watch<AppData>().cakes;

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
              title: '${cakes[0].categoryId} Cake',
              type: TitleTextType.subTitleBlack,
              weight: FontWeight.w800,
            ),
            SelectionRow(cakes),
          ],
        ),
      ),
    );
  }
}
