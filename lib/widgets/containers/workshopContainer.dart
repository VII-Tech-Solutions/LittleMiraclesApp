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
//PAGES
import '../../pages/home/workshopDetailsPage.dart';

class WorkshopContainer extends StatelessWidget {
  final Workshop? workshop;
  const WorkshopContainer(this.workshop);

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
    return InkWell(
      onTap: () {
        if (workshop?.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkshopDetailsPage(workshop),
            ),
          );
        }
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
                    '${workshop?.title}',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'BD${workshop?.price}',
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
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                getDate('${workshop?.postedAt}'),
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
