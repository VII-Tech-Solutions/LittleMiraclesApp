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
      CachedImageWidget(
        'https://i.picsum.photos/id/514/343/200.jpg?hmac=agi3cn4az37bjgHqfKu0Ffo1EbYYSd5IRopJpWgdpXg',
        ImageShape.rectangle,
        customBoxFit: BoxFit.none,
        radius: 0.0,
      ),
      CachedImageWidget(
        'https://i.picsum.photos/id/304/343/300.jpg?hmac=ihrb8Va_phgzQqomNxAkLmxbWYGDG_FF1HDcAtGlIvc',
        ImageShape.rectangle,
        customBoxFit: BoxFit.fitHeight,
        radius: 0.0,
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
              height: 350,
              child: items[index],
            );
          },
        ),
      ),
    );
  }
}
