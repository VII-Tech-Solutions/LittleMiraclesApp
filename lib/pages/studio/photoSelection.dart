//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/containers/photoSelectionContainer.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
//PAGES

class PhotoSelection extends StatelessWidget {
  const PhotoSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessions = context.watch<AppData>().completedSessions;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Photo Selection',
        weight: FontWeight.w800,
      ),
      body: sessions.isEmpty
          ? SafeArea(
              child: Center(
                // TODO:: get the design and set the style
                child: Text("You don't have any completed sessions yet."),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
              child: Column(
                children:
                    sessions.map((e) => PhotoSelectionContainer(e)).toList(),
              ),
            ),
      bottomNavigationBar: StudioBottomSectionContainer(
        btnLabel: 'Add to Cart',
        showSlectedImages: true,
        onTap: () {},
      ),
    );
  }
}
