//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/general/cachedImageWidget.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithClose.dart';
//PAGES

class ImageExamplePage extends StatelessWidget {
  final Package? package;
  const ImageExamplePage(this.package);

  @override
  Widget build(BuildContext context) {
    final items = [
      Image(
        image: NetworkImage(
            'https://i.picsum.photos/id/514/343/200.jpg?hmac=agi3cn4az37bjgHqfKu0Ffo1EbYYSd5IRopJpWgdpXg'),
        fit: BoxFit.fill,
      ),
      Image(
        image: NetworkImage(
            'https://i.picsum.photos/id/304/343/300.jpg?hmac=ihrb8Va_phgzQqomNxAkLmxbWYGDG_FF1HDcAtGlIvc'),
        fit: BoxFit.cover,
      ),
      Image(
        image: NetworkImage(
            'https://i.picsum.photos/id/291/343/400.jpg?hmac=G0E7KRKSGWzuEF8lXaHDLbEX_ZI3-BldVqF8x1cs8u4'),
        fit: BoxFit.fitHeight,
      ),
      Image(
        image: NetworkImage(
            'https://i.picsum.photos/id/380/343/256.jpg?hmac=VOLQGXewDD74KH0BEbo0PNWcrf0ISoCcB8-HAxaGAG8'),
        fit: BoxFit.cover,
      ),
    ];

    return Scaffold(
      appBar: AppBarWithClose('Image Examples', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: items[index],
            );
          },
        ),
      ),
    );
  }
}
