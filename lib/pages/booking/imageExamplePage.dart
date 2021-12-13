//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithClose.dart';
//PAGES

class ImageExamplePage extends StatelessWidget {
  final List<String>? images;
  const ImageExamplePage(this.images);

  @override
  Widget build(BuildContext context) {
    final placeholder = GlobalHelpers.randomPlaceholder('r');

    return Scaffold(
      appBar: AppBarWithClose('Image Examples', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: images?.length,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CachedNetworkImage(
                imageUrl: images?[index] ?? '',
                width: double.infinity,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => placeholder,
                errorWidget: (context, url, error) => placeholder,
              ),
            );
          },
        ),
      ),
    );
  }
}
