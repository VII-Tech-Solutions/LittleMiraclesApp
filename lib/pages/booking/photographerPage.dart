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
import '../../widgets/bookingSessonContainers/selectionRow.dart';
//PAGES

class PhotographerPage extends StatefulWidget {
  const PhotographerPage({Key? key}) : super(key: key);

  @override
  _PhotographerPageState createState() => _PhotographerPageState();
}

class _PhotographerPageState extends State<PhotographerPage> {
  @override
  Widget build(BuildContext context) {
    final photographers = context.watch<AppData>().photographers;

    return Scaffold(
      appBar: AppBarWithBack(
        'Select Cake',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectionRow(photographers),
          ],
        ),
      ),
    );
  }
}
