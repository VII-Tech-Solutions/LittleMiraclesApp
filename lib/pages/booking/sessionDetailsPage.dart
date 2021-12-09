//PACKAGES

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
import '../../widgets/general/sessionDetailsRow.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/reviewContainer.dart';
import '../../widgets/containers/imageGrid.dart';
//PAGES

class SessionDetailsPage extends StatelessWidget {
  final Package? package;
  const SessionDetailsPage(this.package);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              Navigator.maybePop(context);
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
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 375,
                  width: double.infinity,
                  child: CachedImageWidget(
                    package?.image,
                    ImageShape.square,
                    radius: 0.0,
                  ),
                ),
                Container(
                  height: 375,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.black162534.withOpacity(0.0),
                        AppColors.black162534,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: package?.isPopular == true ? 220 : 245,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: package?.isPopular ?? false,
                        child: Container(
                          height: 24,
                          width: 147,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.orangeFF6B00,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                'POPULAR SESSION',
                                style: TextStyle(
                                  color: AppColors.whiteFFFFFF,
                                  fontSize: 10,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TitleText(
                        customPadding:
                            const EdgeInsets.only(top: 10.0, bottom: 5.0),
                        title: package?.title ?? '',
                        type: TitleTextType.containerMainTitle,
                      ),
                      TitleText(
                        customPadding: const EdgeInsets.only(bottom: 5.0),
                        title: package?.tag ?? '',
                        type: TitleTextType.subContainerMainTitle,
                      ),
                      TitleText(
                        customPadding: const EdgeInsets.all(0),
                        title: 'BD ${package?.price ?? ''}',
                        type: TitleTextType.subContainerMainTitle,
                        weight: FontWeight.w800,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Text(
                    'Package Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 16.0, left: 16.0, right: 16.0),
                  child: Text(
                    'Maternity, baby at least 6 months sitters or cakesmash',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
                SessionRowDetails(
                  '30 minutes in the studio',
                  Icons.access_time,
                ),
                SessionRowDetails(
                  '1 styled background',
                  Icons.wallpaper,
                ),
                SessionRowDetails(
                  '1 outfit change',
                  Icons.checkroom,
                ),
                SessionRowDetails(
                  '15 digital images',
                  Icons.photo_library,
                ),
                SessionRowDetails(
                  '1 baby, child or adult',
                  Icons.perm_identity,
                ),
                SessionRowDetails(
                  'Use of studio, wardrobe and accessories',
                  Icons.flare,
                ),
                SessionRowDetails(
                  'Cake included in cakesmash session',
                  Icons.cake,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 16.0),
                  child: Text(
                    'Studio Location',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, bottom: 15, left: 16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.place_outlined,
                          color: AppColors.black45515D,
                          size: 16.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          package?.locationText ?? '',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (package?.locationLink != null) {
                            String url = package?.locationLink ?? ' ';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        },
                        child: Container(
                          height: 177,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: AppColors.greyD0D3D6,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/map.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 139),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.whiteFFFFFF,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                            border: Border.all(
                              color: AppColors.greyD0D3D6,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Get Directions',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 16.0, bottom: 10.0),
                  child: Text(
                    'Image Examples',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
                Center(
                  child: ImageGridWidget(package?.image ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FilledButtonWidget(
                    onPress: () {
                      //TODO: go to all image examples
                    },
                    type: ButtonType.generalGrey,
                    title: 'See all examples',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 6.0),
                        child: Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.black45515D,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: 4.5,
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: AppColors.yellowFFB400,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Text(
                          '(6 Reviews)',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.black45515D,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(left: 16.0),
                  height: 133.0,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 16.0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ReviewContainer(),
                      ReviewContainer(),
                      ReviewContainer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 30.0, left: 16.0, right: 16.0),
                  child: FilledButtonWidget(
                    onPress: () {
                      //TODO: go to all reviews
                    },
                    type: ButtonType.generalGrey,
                    title: 'See all reviews',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: AppColors.greyF2F3F3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 0.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${package?.title}',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'BD ${package?.price}',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FilledButtonWidget(
                            customWidth: 128,
                            onPress: () {
                              //TODO: go to book now
                            },
                            type: ButtonType.generalBlue,
                            title: 'Book Now',
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
