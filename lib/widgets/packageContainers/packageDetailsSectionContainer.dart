//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/sessionDetailsRow.dart';
//PAGES

class PackageDetailsSectionContainer extends StatelessWidget {
  const PackageDetailsSectionContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Package Details',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Text(
              'Maternity, baby at least 6 months sitters or cakesmash',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          SessionRowDetails(
            '30 minutes in the studio',
            Icons.access_time,
          ),
          SessionRowDetails(
            '1 styled background',
            Icons.wallpaper,
          ),
          SessionRowDetails(
            '1 outfit change',
            Icons.checkroom,
          ),
          SessionRowDetails(
            '15 digital images',
            Icons.photo_library,
          ),
          SessionRowDetails(
            '1 baby, child or adult',
            Icons.perm_identity,
          ),
          SessionRowDetails(
            'Use of studio, wardrobe and accessories',
            Icons.flare,
          ),
          SessionRowDetails(
            'Cake included in cakesmash session',
            Icons.cake,
          ),
        ],
      ),
    );
  }
}
