//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
import '../../../providers/appData.dart';
//WIDGETS
import '../../../widgets/buttons/iconButtonWidget.dart';
import '../../../widgets/sessionContainers/sessionTopSectionContainer.dart';
import '../../../widgets/sessionContainers/sessionDetailsContainer.dart';
import '../../../widgets/sessionContainers/sessionStatusStepperContainer.dart';
import '../../../widgets/sessionContainers/sessionButtonsContainer.dart';
import '../../../widgets/sessionContainers/guidelinesButtonWidget.dart';
//PAGES

class UpcomingSessionDetailsPage extends StatelessWidget {
  const UpcomingSessionDetailsPage();

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AppData>().session;
    List<Widget> _list = [
      SessionDetailsContainer(),
      GuidelinesButtonWidget(
        session,
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      ),
      SessionStatusStepperContainer(),
      SessionButtonContainer(),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: IconButtonWidget(
              onPress: () {
                Navigator.maybePop(context);
              },
              icon: Icons.arrow_back,
            ),
            stretch: true,
            backgroundColor: Colors.white,
            expandedHeight: 375,
            flexibleSpace: FlexibleSpaceBar(
              background: SessionTopSectionContainer(),
              stretchModes: [
                StretchMode.zoomBackground,
              ],
            ),
          ),
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