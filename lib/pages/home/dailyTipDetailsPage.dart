//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/dailyTip.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/HtmlDescriptionText.dart';
//PAGES

class DailyTipDetailsPage extends StatelessWidget {
  final DailyTip? dailyTip;
  const DailyTipDetailsPage(this.dailyTip);

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
          'Your daily tip',
          style: TextStyle(
            color: AppColors.black45515D,
            fontSize: 18,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
          ),
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
                    imageUrl: '${dailyTip?.image}',
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
                getDate('${dailyTip?.postedAt}'),
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
                  '${dailyTip?.title}',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              HtmlDescriptionText('${dailyTip?.content}'),
            ],
          ),
        ),
      ),
    );
  }
}