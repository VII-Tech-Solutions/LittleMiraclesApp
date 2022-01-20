//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/mainPagesSliverAppBar.dart';
//PAGES

class BookingMainPage extends StatefulWidget {
  const BookingMainPage({Key? key}) : super(key: key);

  @override
  _BookingMainPageState createState() => _BookingMainPageState();
}

class _BookingMainPageState extends State<BookingMainPage> {
  @override
  Widget build(BuildContext context) {
    final _list = context.watch<AppData>().bookingList;
    return CustomScrollView(
      slivers: <Widget>[
        MainPagesSliverAppBar('Photo', 'Sessions 📸'),
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