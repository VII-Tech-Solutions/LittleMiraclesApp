//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
import '../../models/media.dart';
import '../../widgets/appbars/appBarWithClose.dart';

//EXTENSIONS

class ImageExamplePage extends StatelessWidget {
  final List<Media> media;
  const ImageExamplePage(this.media);

  @override
  Widget build(BuildContext context) {
    final placeholder = GlobalHelpers.randomPlaceholder('s');

    return Scaffold(
      appBar: AppBarWithClose('Image Examples', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: media.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 600),
              child: CachedNetworkImage(
                imageUrl: media[index].url ?? '',
                width: double.infinity,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => placeholder,
                errorWidget: (context, url, error) => placeholder,
              ),
            ),
          );
        },
      ),
    );
  }
}
