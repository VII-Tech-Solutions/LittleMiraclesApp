//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/promotion.dart';
//PROVIDERS
//WIDGETS
//PAGES
import '../../pages/home/promotionDetailsPage.dart';

class PromotionContainer extends StatelessWidget {
  final Promotion? promotion;
  const PromotionContainer(this.promotion);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //todo go to Daily Tip deatils page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PromotionDetails(promotion),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 177,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: '${promotion?.image}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.blue8DC4CB,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${promotion?.title}',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '${promotion?.offer}',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: AppColors.pinkEF5DA8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Promotions'.toUpperCase(),
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontWeight: FontWeight.w200,
                        fontSize: 10.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
