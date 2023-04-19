//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/booking/image_preview_page.dart';
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
      appBar: AppBarWithClose('Gallery Photos', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: ListView.separated(
        itemCount: media.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        separatorBuilder: (ctx, index) => SizedBox(height: 10),
        itemBuilder: (ctx, index) {
          final url = media[index].url ?? '';
          final tag = 'tag$index';
          return GestureDetector(
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewPage(url, tag),
                  ),
                )),
            child: Hero(
              tag: tag,
              child: CachedNetworkImage(
                imageUrl: url,
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                maxHeightDiskCache: 500,
                maxWidthDiskCache: 500,
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
