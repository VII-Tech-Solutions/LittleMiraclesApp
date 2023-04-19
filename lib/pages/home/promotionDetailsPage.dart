//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
import '../../models/promotion.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/HtmlDescriptionText.dart';

class PromotionDetails extends StatelessWidget {
  final Promotion? promotion;
  const PromotionDetails(this.promotion);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Promotions',
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
                  promotion?.id,
                  promotion?.image,
                  ImageShape.rectangle,
                ),
              ),
            ),
            Text(
              DateFormatClass().toddMMyyyy(promotion!.createdAt!),
              style: TextStyle(
                color: AppColors.black45515D,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 16.0,
              ),
              child: Text(
                promotion?.title ?? '',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            HtmlDescriptionText(promotion?.content ?? ''),
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              height: 80,
              child: Container(
                width: double.infinity,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.greyF2F3F3,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.greyD0D3D6),
                ),
                child: Text(
                  promotion?.promoCode ?? '',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
            ),
            Text(
              '*This gift is valid until ${DateFormatClass().toddMMyyyy('${promotion?.validUntil}')}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
            FilledButtonWidget(
              onPress: () {
                final snackBar = SnackBar(
                  behavior: SnackBarBehavior.floating,
                  elevation: 2,
                  duration: Duration(seconds: 2),
                  content: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Promo Code Copied',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  backgroundColor: AppColors.black2D3B48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
                Clipboard.setData(
                  ClipboardData(text: promotion?.promoCode ?? ''),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              margin: const EdgeInsets.only(top: 30.0, bottom: 49.0),
              type: ButtonType.generalBlue,
              title: 'Copy Promo Code',
            ),
          ],
        ),
      ),
    );
  }
}
