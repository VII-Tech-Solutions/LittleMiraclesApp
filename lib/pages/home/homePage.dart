//PACKAGES

// Dart imports:
import 'dart:math';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/providers/bookings.dart';
import 'package:confetti/confetti.dart';
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
  final bool showConfetti;
  const HomePage({
    this.showConfetti = false,
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConfettiController confettiController =
      ConfettiController(duration: Duration(seconds: 5));

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.showConfetti == true) {
      confettiController.play();
    }
    Future.delayed(
      Duration(seconds: 5),
    ).then(
      (value) {
        if (mounted) {
          if (context.read<Bookings>().showAppRateDiag == true) {
            showDialog(
              barrierDismissible: true,
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
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final isAuth = context.read<Auth>().isAuth;
    // final helloSection = context.read<AppData>().helloSection;
    // final size = MediaQuery.of(context).size;
    // final statusBarHeight = MediaQuery.of(context).padding.top;
    // final statusBarHeights = MediaQueryData.fromWindow(ui.window).padding.top;
    final _list = context.watch<AppData>().sessionsAndHomeList;
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
      child: Stack(
        children: [
          CustomScrollView(
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
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              confettiController: confettiController,
              numberOfParticles: 4,
              shouldLoop: false,
              gravity: 0.09,
              blastDirection: pi / 4,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              confettiController: confettiController,
              numberOfParticles: 4,
              shouldLoop: false,
              gravity: 0.09,
              blastDirection: (3 * pi / 4),
            ),
          ),
        ],
      ),
    );
  }
}
