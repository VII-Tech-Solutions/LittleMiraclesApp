//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/mainPagesSliverAppBar.dart';
//PAGES

class MoreMainPage extends StatelessWidget {
  const MoreMainPage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        MainPagesSliverAppBar('More', 'Settings ⚙️'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                height: 50,
                color: Colors.red,
              );
            },
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
