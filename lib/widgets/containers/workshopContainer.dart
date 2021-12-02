//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
import '../../models/workshop.dart';
//PROVIDERS
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES
import '../../pages/home/workshopDetailsPage.dart';

class WorkshopContainer extends StatelessWidget {
  final Workshop? workshop;
  const WorkshopContainer(this.workshop);

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
              child: CachedImageWidget(
                workshop?.image,
                ImageShape.rectangle,
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
                DateFormatClass().getDate('${workshop?.postedAt}'),
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
