import 'package:LMP0001_LittleMiraclesApp/global/globalHelpers.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithClose.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../global/colors.dart';

class ImagePreviewPage extends StatelessWidget {
  final String? url;
  final String tag;
  const ImagePreviewPage(this.url, this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholder = GlobalHelpers.randomPlaceholder('s');
    return Scaffold(
      appBar: AppBarWithClose('', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: SafeArea(
        child: InteractiveViewer(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: Hero(
              tag: tag,
              child: CachedNetworkImage(
                imageUrl: url ?? '',
                width: double.infinity,
                fit: BoxFit.fitWidth,
                maxHeightDiskCache: 500,
                maxWidthDiskCache: 500,
                placeholder: (context, url) => placeholder,
                errorWidget: (context, url, error) => placeholder,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
