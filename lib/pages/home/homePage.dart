//PACKAGES

// Dart imports:
import 'dart:ui' as ui;

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/providers/bookings.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/homeHeaderSliverAppBar.dart';
import '../../widgets/appbars/loginSliverAppBar.dart';
import '../booking/rateDialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 1),
    ).then(
      (value) {
        if (context.read<Bookings>().showAppRateDiag == true) {
          print('object');
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                insetPadding: const EdgeInsets.all(0),
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: RateDialog(),
              );
            },
          );
        }
      },
    );
  }

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
