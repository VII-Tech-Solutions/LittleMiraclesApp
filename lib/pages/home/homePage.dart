//PACKAGES

// Dart imports:
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/homeHeaderSliverAppBar.dart';
import '../../widgets/appbars/loginSliverAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isAuth = context.read<Auth>().isAuth;
    final helloSection = context.read<AppData>().helloSection;
    final size = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final statusBarHeights = MediaQueryData.fromWindow(ui.window).padding.top;

    final _list = context.watch<AppData>().sessionsAndHomeList;
    return CustomScrollView(
      slivers: <Widget>[
        HomeHeaderSliverAppBar(),
        LoginSliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _list[index];
            },
            childCount: _list.length,
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(bottom: 30))
      ],
    );
  }
}
