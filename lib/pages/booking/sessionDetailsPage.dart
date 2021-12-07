//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
import '../../widgets/general/sessionDetailsRow.dart';
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
                    left: 30,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 16.0, 16.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 16.0),
                    child: Text(
                      'Maternity, baby at least 6 months sitters or cakesmash',
                      style: TextStyle(
                        fontSize: 14,
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
                    padding: const EdgeInsets.only(top: 41.0),
                    child: Text(
                      'Studio Location',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8.0, bottom: 16.0),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
