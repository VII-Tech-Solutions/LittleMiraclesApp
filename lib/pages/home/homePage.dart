//PACKAGES

// Dart imports:
import 'dart:math';

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

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    // final isAuth = context.read<Auth>();

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
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              numberOfParticles: 1,
              maxBlastForce: 20,
              minBlastForce: 5,
              emissionFrequency: 1,
              shouldLoop: false,
              gravity: 0.05,
              // blastDirection: pi / 2,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [
                Color(0xffABC1C3),
                Color(0xffB6D8DB),
                Color(0xffE2C5BB),
                Color(0xffA59998),
                Color(0xff6D6A6A),
              ],
              createParticlePath: drawStar,
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: ConfettiWidget(
          //     confettiController: confettiController,
          //     numberOfParticles: 4,
          //     shouldLoop: false,
          //     gravity: 0.09,
          //     blastDirection: (3 * pi / 4),
          // colors: const [
          //   Colors.green,
          //   Colors.blue,
          //   Colors.pink,
          //   Colors.orange,
          //   Colors.purple
          // ],
          // createParticlePath: drawStar,
          // ),
          // ),
        ],
      ),
    );
  }
}
