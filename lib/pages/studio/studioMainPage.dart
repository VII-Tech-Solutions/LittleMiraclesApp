//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/emptySliverAppBar.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../providers/appData.dart';
import '../../providers/auth.dart';
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
    return RefreshIndicator(
      onRefresh: (() async {
        final token = context.read<Auth>().token;
        if (token.isNotEmpty) {
          await context.read<AppData>().fetchAndSetSessions(token: token);
        }
        await context.read<AppData>().fetchAndSetAppData();
      }),
      edgeOffset: kToolbarHeight + 9,
      displacement: kToolbarHeight + 9,
      child: CustomScrollView(
        slivers: <Widget>[
          EmptySliverAppBar(),
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
      ),
    );
  }
}
