//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/workshop.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/HtmlDescriptionText.dart';
import '../../widgets/appbars/appBarWithBack.dart';
//PAGES

class WorkshopDetailsPage extends StatelessWidget {
  final Workshop? workshop;
  const WorkshopDetailsPage(this.workshop);

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
      appBar: AppBarWithBack(title: 'Workshop'),
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
                    imageUrl: '${workshop?.image}',
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
                getDate('${workshop?.postedAt}'),
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
                  '${workshop?.title}',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              HtmlDescriptionText('${workshop?.content}'),
            ],
          ),
        ),
      ),
    );
  }
}
