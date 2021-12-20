//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/imageGrid.dart';
//PAGES
import '../../pages/booking/imageExamplePage.dart';

class PackageImageSectionContainer extends StatelessWidget {
  const PackageImageSectionContainer();

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    return InkWell(
      onTap: () {
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
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
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
            FilledButtonWidget(
              onPress: null,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              type: ButtonType.generalGrey,
              title: 'See all examples',
            ),
          ],
        ),
      ),
    );
  }
}
