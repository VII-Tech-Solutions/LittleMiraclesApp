//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/imageGrid.dart';
//PAGES
import '../../pages/booking/imageExamplePage.dart';

class PackageImageSectionContainer extends StatelessWidget {
  final Package? package;
  const PackageImageSectionContainer(this.package);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, bottom: 10.0),
            child: Text(
              'Image Examples',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Center(
            child: ImageGridWidget(package?.image ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButtonWidget(
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageExamplePage(package),
                  ),
                );
              },
              type: ButtonType.generalGrey,
              title: 'See all examples',
            ),
          ),
        ],
      ),
    );
  }
}
