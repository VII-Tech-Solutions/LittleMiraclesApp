//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES
import '../../pages/home/dailyTipDetailsPage.dart';

class TipContainer extends StatelessWidget {
  final String? title;
  final String? url;
  const TipContainer({Key? key, @required this.title, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //todo go to Daily Tip deatils page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyTipDetails(),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.0,
          22.0,
          16.0,
          10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 177,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.blue8DC4CB,
              ),
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
                //todo fix placeholder
                placeholder: (context, url) => Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Welcome to Little Miracles by Sherinr',
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Row(
                children: [
                  //todo change the icon to match the design
                  Icon(
                    Icons.lightbulb_rounded,
                    size: 16,
                    color: AppColors.yellowFFB400,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Tips & Tricks'.toUpperCase(),
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
