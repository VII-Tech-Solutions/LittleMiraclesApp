//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessonContainers/selectionRow.dart';
//PAGES

class BackdropPage extends StatelessWidget {
  const BackdropPage({Key? key}) : super(key: key);

  Widget _buildContainer(String title, Widget childWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.black45515D,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.03),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 10,
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: childWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.watch<AppData>();
    final bookingsProvider = context.watch<AppData>();

    return Scaffold(
      appBar: AppBarWithBack(
        'Select Backdrop',
        weight: FontWeight.w800,
      ),
      body: ListView.builder(
        itemCount: appDataProvider.backdropCategories.length,
        itemBuilder: (BuildContext context, int index) {
          final int? catId = appDataProvider.backdropCategories[index].id;
          final String? title = appDataProvider.backdropCategories[index].name;
          if (appDataProvider.getBackdropsByCategoryId(catId!).isNotEmpty) {
            return _buildContainer(
              title!,
              Column(
                children: appDataProvider
                    .getBackdropsByCategoryId(catId)
                    .map(
                      (e) => Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
