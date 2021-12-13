//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/imageGrid.dart';
//PAGES
import '../../pages/booking/imageExamplePage.dart';

class PackageImageSectionContainer extends StatelessWidget {
  final Package? package;
  const PackageImageSectionContainer(this.package);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageExamplePage([
              'https://i.picsum.photos/id/514/343/200.jpg?hmac=agi3cn4az37bjgHqfKu0Ffo1EbYYSd5IRopJpWgdpXg',
              'https://i.picsum.photos/id/304/343/300.jpg?hmac=ihrb8Va_phgzQqomNxAkLmxbWYGDG_FF1HDcAtGlIvc',
            ]),
          ),
        );
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 16.0, bottom: 10.0),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageExamplePage([
                        'https://i.picsum.photos/id/514/343/200.jpg?hmac=agi3cn4az37bjgHqfKu0Ffo1EbYYSd5IRopJpWgdpXg',
                        'https://i.picsum.photos/id/304/343/300.jpg?hmac=ihrb8Va_phgzQqomNxAkLmxbWYGDG_FF1HDcAtGlIvc',
                        'https://i.picsum.photos/id/112/343/400.jpg?hmac=-04JmOPZENdYxUybn8DJYSpYdAG07GsHmE4ZOLRxc-Y',
                        'https://i.picsum.photos/id/591/343/256.jpg?hmac=4HZvluquq6Vt1oGDHYTjK8iH7C8YLm_dhsf8oqsjwMY',
                      ]),
                    ),
                  );
                },
                type: ButtonType.generalGrey,
                title: 'See all examples',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
