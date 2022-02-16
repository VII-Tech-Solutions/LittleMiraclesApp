//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/reviewContainer.dart';
//PAGES
import '../../pages/general/reviewsPage.dart';

class PackageRatingSectionContainer extends StatelessWidget {
  const PackageRatingSectionContainer();

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final reviewsList = context.watch<Bookings>().packageReviews;

    return Visibility(
      visible: package?.totalReviews != 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Row(
              children: [
                Text(
                  '${package?.rating ?? 0.0}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: RatingBarIndicator(
                    rating: package?.rating ?? 0.0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rounded,
                      color: AppColors.yellowFFB400,
                    ),
                    unratedColor: AppColors.greyB9BEC2,
                    itemCount: 5,
                    itemSize: 15.0,
                  ),
                ),
                Text(
                  '(${package?.totalReviews ?? 0} Reviews)',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.black45515D,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 133,
            child: ListView.builder(
              itemCount: reviewsList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 13),
              itemBuilder: (context, index) =>
                  ReviewContainer(reviewsList[index]),
            ),
          ),
          FilledButtonWidget(
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewsPage(),
                ),
              );
            },
            margin: const EdgeInsets.fromLTRB(16, 11, 16, 30),
            type: ButtonType.generalGrey,
            title: 'See all reviews',
          ),
        ],
      ),
    );
  }
}
