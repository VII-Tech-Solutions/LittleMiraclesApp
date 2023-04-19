import 'package:flutter/material.dart';

class EmptySliverAppBar extends StatelessWidget {
  const EmptySliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 0,
      expandedHeight: 0,
      pinned: true,
      elevation: 0,
    );
  }
}
