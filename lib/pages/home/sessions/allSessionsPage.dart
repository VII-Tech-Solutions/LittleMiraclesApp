//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../providers/appData.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/loggedUserContainers/homeSessionContainer.dart';

//EXTENSIONS

class AllSessionPage extends StatelessWidget {
  const AllSessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionsList = context.watch<AppData>().sessions;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'All Sessions',
        elevation: 0,
        weight: FontWeight.w800,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 40),
        itemCount: sessionsList.length,
        itemBuilder: (context, index) => HomeSessionContainer(
          sessionsList[index],
        ),
      ),
    );
  }
}
