//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/texts/titleText.dart';
import '../../widgets/bookingSessonContainers/selectionRow.dart';
//PAGES

class BackdropPage extends StatelessWidget {
  const BackdropPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backdrops = context.watch<AppData>().backdrops;

    return Scaffold(
      appBar: AppBarWithBack(
        'Select Backdrop',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              title: 'Backdrop type 1 - ${backdrops[0].category}',
              type: TitleTextType.subTitleBlack,
              weight: FontWeight.w800,
            ),
            SelectionRow(backdrops),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: appDataProvider.backdrops.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       final int? catId = appDataProvider.backdrops[index].id;
            //       final String? title = appDataProvider.backdrops[index].title;

            //       // return _buildContainer(
            //       //   title!,
            //       //   Column(
            //       //     children: appDataProvider
            //       //         .getSchoolContactsByCategory(catId)
            //       //         .map((e) =>
            //       //             _buildContactRow(e.title!, e.phone!, e.email!))
            //       //         .toList(),
            //       //   ),
            //       // );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
