//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
import '../../models/media.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithClose.dart';
//PAGES

class ImageExamplePage extends StatelessWidget {
  final List<Media> media;
  const ImageExamplePage(this.media);

  @override
  Widget build(BuildContext context) {
    final placeholder = GlobalHelpers.randomPlaceholder('r');

    return Scaffold(
      appBar: AppBarWithClose('Image Examples', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: media.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CachedNetworkImage(
              imageUrl: media[index].url ?? '',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => placeholder,
              errorWidget: (context, url, error) => placeholder,
            ),
          );
        },
      ),
    );
  }
}
