//PACKAGES
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/homeHeaderSliverAppBar.dart';
import '../../widgets/appbars/loginSliverAppBar.dart';
//PAGES

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
