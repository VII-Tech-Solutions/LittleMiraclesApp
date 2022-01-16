//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/mainPagesSliverAppBar.dart';
//PAGES

class StudioMainPage extends StatefulWidget {
  const StudioMainPage({Key? key}) : super(key: key);

  @override
  _StudioMainPageState createState() => _StudioMainPageState();
}

class _StudioMainPageState extends State<StudioMainPage> {
  @override
  Widget build(BuildContext context) {
    final _list = context.watch<AppData>().studioList;
    return CustomScrollView(
      slivers: <Widget>[
        MainPagesSliverAppBar('Printing', 'Studio ♥️'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _list[index];
            },
            childCount: _list.length,
          ),
        ),
      ],
    );
  }
}
