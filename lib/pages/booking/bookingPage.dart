//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/pagesSliverAppBar.dart';
import '../../widgets/containers/sessionContainer.dart';
//PAGES

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    //return SessionContainer();
    return CustomScrollView(
      slivers: <Widget>[
        PagesSliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  SessionContainer(true),
                  SessionContainer(false),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
