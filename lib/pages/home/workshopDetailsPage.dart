//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
import '../../models/workshop.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/texts/HtmlDescriptionText.dart';
import '../../widgets/appbars/appBarWithBack.dart';
//PAGES

class WorkshopDetailsPage extends StatelessWidget {
  final Workshop? workshop;
  const WorkshopDetailsPage(this.workshop);

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
                          fit: BoxFit.cover,
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
                DateFormatClass().getDate('${workshop?.postedAt}'),
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
