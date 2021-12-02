//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

enum ImageShape {
  square,
  rectangle,
}

class CachedImageWidget extends StatelessWidget {
  final String? url;
  final ImageShape imageShape;
  const CachedImageWidget(this.url, this.imageShape);

  @override
  Widget build(BuildContext context) {
    final placeholder = GlobalHelpers.randomPlaceholder(
        imageShape == ImageShape.rectangle ? 'r' : 's');
    return CachedNetworkImage(
      imageUrl: url ?? '',
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => placeholder,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.blue8DC4CB,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
