//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/emptySliverAppBar.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../providers/appData.dart';
import '../../widgets/appbars/mainPagesSliverAppBar.dart';

class BookingMainPage extends StatefulWidget {
  const BookingMainPage({Key? key}) : super(key: key);

  @override
  _BookingMainPageState createState() => _BookingMainPageState();
}

class _BookingMainPageState extends State<BookingMainPage> {
  @override
  Widget build(BuildContext context) {
    final _list = context.watch<AppData>().bookingList;
    return RefreshIndicator(
      onRefresh: (() async {
        print('hahaahaha');
      }),
      edgeOffset: kToolbarHeight + 9,
      child: CustomScrollView(
        slivers: <Widget>[
          EmptySliverAppBar(),
          MainPagesSliverAppBar('Photo', 'Sessions 📸'),
          SliverPadding(
            padding: EdgeInsets.only(top: 8),
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
