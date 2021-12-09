//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/reviewContainer.dart';
//PAGES

class PackageRatingSectionContainer extends StatelessWidget {
  final Package? package;
  const PackageRatingSectionContainer(this.package);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 6.0),
                  child: Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RatingBarIndicator(
                  rating: 4.5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star_rounded,
                    color: AppColors.yellowFFB400,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Text(
                    '(6 Reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(left: 16.0),
            height: 133.0,
            child: ListView(
              padding: const EdgeInsets.only(left: 16.0),
              scrollDirection: Axis.horizontal,
              children: [
                ReviewContainer(),
                ReviewContainer(),
                ReviewContainer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 30.0, left: 16.0, right: 16.0),
            child: FilledButtonWidget(
              onPress: () {
                //TODO: go to all reviews
              },
              type: ButtonType.generalGrey,
              title: 'See all reviews',
            ),
          ),
        ],
      ),
    );
  }
}
