//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../providers/appData.dart';
import '../../../widgets/buttons/iconButtonWidget.dart';
import '../../../widgets/sessionContainers/completedSubSessionContainer.dart';
import '../../../widgets/sessionContainers/expandableSessionDetailsContainer.dart';
import '../../../widgets/sessionContainers/guidelinesButtonWidget.dart';
import '../../../widgets/sessionContainers/sessionButtonsContainer.dart';
import '../../../widgets/sessionContainers/sessionDetailsContainer.dart';
import '../../../widgets/sessionContainers/sessionStatusStepperContainer.dart';
import '../../../widgets/sessionContainers/sessionTopSectionContainer.dart';

//EXTENSIONS

class UpcomingSessionDetailsPage extends StatelessWidget {
  const UpcomingSessionDetailsPage();

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.watch<AppData>();
    final session = appDataProvider.session;
    final subSessionList =
        appDataProvider.getSubSessionsByIds(session?.subSessionsIds);
    List<Widget> _list = [
      SessionDetailsContainer(),
      GuidelinesButtonWidget(
        session,
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      ),
      SessionStatusStepperContainer(),
      // SessionButtonContainer(),
      SizedBox(
        height: 78,
      )
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
          session?.subSessionsIds != null
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: subSessionList
                            .map((subSession) => subSession.status == 5
                                ? CompletedSubSessionContainer(subSession)
                                : ExpandableSessionDetailsContainer(subSession))
                            .toList(),
                      );
                    },
                    childCount: 1,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _list[index];
                    },
                    childCount: _list.length,
                  ),
                ),
          SliverPadding(
            padding: session?.subSessionsIds != null
                ? const EdgeInsets.only(bottom: 30)
                : EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
