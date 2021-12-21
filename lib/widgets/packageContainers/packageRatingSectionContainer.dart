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
import '../../widgets/containers/rateSessionContainer.dart';
//PAGES
import '../../pages/general/reviewsPage.dart';

class PackageRatingSectionContainer extends StatelessWidget {
  const PackageRatingSectionContainer();

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;

    var userRating = TextEditingController();
    return package?.totalReviews == 0
        ? Container(
            height: 254,
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.greyD0D3D6,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 49,
                      width: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColors.pinkFEF2F1,
                      ),
                      child: TextField(
                        controller: userRating,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black45515D,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                        decoration: InputDecoration(
                          hintText: '4.0',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      glow: false,
                      updateOnDrag: true,
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: AppColors.yellowFFB400,
                      ),
                      onRatingUpdate: (rating) {
                        userRating.text = '$rating';
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.blue,
                  ),
                ),
                Container(
                  width: 143,
                  height: 38,
                  color: Colors.black,
                ),
              ],
            ),
          )
        : Column(
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
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  itemBuilder: (context, index) => ReviewContainer(),
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
          );
  }
}
