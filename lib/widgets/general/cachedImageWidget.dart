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
  final double? radius;
  final BoxFit? customBoxFit;
  final BorderRadius? borderRadius;
  const CachedImageWidget(
    this.url,
    this.imageShape, {
    this.radius = 8.0,
    this.customBoxFit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = GlobalHelpers.randomPlaceholder(
        imageShape == ImageShape.rectangle ? 'r' : 's',
        borderRadius: borderRadius);
    return CachedNetworkImage(
      imageUrl: url ?? '',
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => placeholder,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0.0),
          color: AppColors.blue8DC4CB,
          image: DecorationImage(
            image: imageProvider,
            fit: customBoxFit,
          ),
        ),
      ),
    );
  }
}
