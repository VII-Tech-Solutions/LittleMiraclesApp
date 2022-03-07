//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
import '../../models/dailyTip.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/HtmlDescriptionText.dart';

class DailyTipDetailsPage extends StatelessWidget {
  final DailyTip? dailyTip;
  const DailyTipDetailsPage(this.dailyTip);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Your daily tip',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                height: 177,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.blue8DC4CB,
                ),
                child: CachedImageWidget(
                  dailyTip?.image,
                  ImageShape.rectangle,
                ),
              ),
            ),
            Text(
              DateFormatClass().toddMMyyyy('${dailyTip?.postedAt}'),
              style: TextStyle(
                color: AppColors.black45515D,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 16.0),
              child: Text(
                dailyTip?.title ?? '',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            HtmlDescriptionText(dailyTip?.content ?? ''),
          ],
        ),
      ),
    );
  }
}
