//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../providers/appData.dart';
import '../../widgets/appbars/mainPagesSliverAppBar.dart';

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
