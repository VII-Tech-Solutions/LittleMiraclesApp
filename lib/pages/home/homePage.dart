//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
//MODELS
//PROVIDERS
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
    return CustomScrollView(
      slivers: <Widget>[
        HomeHeaderSliverAppBar(),
        LoginSliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaleFactor: 5),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
