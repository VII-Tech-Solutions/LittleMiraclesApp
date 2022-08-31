//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../models/review.dart';
import '../general/cachedImageWidget.dart';

//EXTENSIONS

class ReviewContainer extends StatelessWidget {
  final Review review;
  final Color? borderColor;
  const ReviewContainer(this.review, {this.borderColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: 133,
        width: size.width * 0.765,
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteFFFFFF,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: borderColor ?? AppColors.greyD0D3D6,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsetsDirectional.only(bottom: 6),
                  child: CachedImageWidget(
                    review.id,
                    review.userImage,
                    ImageShape.square,
                    radius: 50,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${review.rating ?? ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.black45515D,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.yellowFFB400,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          review.userName ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.black45515D,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        review.updatedAt.toString().toddMMMyyyy().toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.grey737C85,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                    child: Text(
                      review.comment ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.black45515D,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
