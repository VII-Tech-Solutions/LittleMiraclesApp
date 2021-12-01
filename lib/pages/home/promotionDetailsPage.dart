//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/general/HtmlDescriptionText.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/promotion.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class PromotionDetails extends StatelessWidget {
  final Promotion? promotion;
  const PromotionDetails(this.promotion);

  String getDate(String date) {
    if (date != 'null') {
      var dateTimeString = date;
      final dateTime = DateTime.parse(dateTimeString);

      final format = DateFormat('dd/MM/yyyy');
      final formattedDate = format.format(dateTime);
      return formattedDate;
    } else {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Promotions',
          style: TextStyle(
            color: AppColors.black45515D,
            fontSize: 18,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.greyF2F3F3,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.black45515D,
              size: 24,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 10.0),
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
                    //todo fix placeholder
                    placeholder: (context, url) => Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Text(
                getDate('${promotion?.postedAt}'),
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
                  '${promotion?.title}',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              HtmlDescriptionText('${promotion?.content}'),
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
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
                    '${promotion?.promoCode}',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
              Text(
                '*This gift is valid until ${promotion?.validUntil}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              FilledButtonWidget(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 49.0,
                ),
                onPress: () {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    elevation: 2,
                    duration: Duration(seconds: 2),
                    content: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: Text(
                        'Promo Code Copied',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    backgroundColor: AppColors.black2D3B48,
                    width: 343,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                  Clipboard.setData(
                    ClipboardData(text: '${promotion?.validUntil}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                type: ButtonType.generalBlue,
                title: 'Copy Promo Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
