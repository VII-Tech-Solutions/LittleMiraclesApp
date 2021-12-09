//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/texts/titleText.dart';
//PAGES

class RateSessionContainer extends StatelessWidget {
  const RateSessionContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    var userRating = TextEditingController();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      height: 284,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.whiteFFFFFF,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RATE THE SESSION',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.grey737C85,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(
                        new FocusNode(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rounded,
                      color: AppColors.yellowFFB400,
                    ),
                    onRatingUpdate: (rating) {
                      userRating.text = '$rating';
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.greyF2F3F3,
                contentPadding:
                    const EdgeInsets.fromLTRB(16.0, 11.0, 16.0, 11.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyF2F3F3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyF2F3F3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyF2F3F3),
                ),
                hintText: 'Add a review (optional)',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.black45515D,
                ),
              ),
            ),
            FilledButtonWidget(
              onPress: () {},
              margin: const EdgeInsets.only(top: 16.0),
              type: ButtonType.generalBlue,
              customWidth: 148,
              title: 'Submit Review',
            )
          ],
        ),
      ),
    );
  }
}
