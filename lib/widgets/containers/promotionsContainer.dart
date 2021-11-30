//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/globalTextWidget.dart';
//PAGES

class PromotionsContainer extends StatelessWidget {
  final String? title;
  final String? percentage;
  final String? url;
  const PromotionsContainer(
      {Key? key, @required this.title, @required this.url, this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        //todo go to Daily Tip deatils page
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.height * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: '$url',
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
                    '$title',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '$percentage',
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
                  miniTitle(context, title: 'Promotions')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
