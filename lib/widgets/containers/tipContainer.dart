//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../models/dailyTip.dart';
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES
import '../../pages/home/dailyTipDetailsPage.dart';

class TipContainer extends StatelessWidget {
  final DailyTip? dailyTip;
  const TipContainer(this.dailyTip);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (dailyTip?.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DailyTipDetailsPage(dailyTip),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
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
                child: CachedImageWidget(
                  dailyTip?.image,
                  ImageShape.rectangle,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                dailyTip?.title ?? '',
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
                      'TIPS & TRICKS',
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
