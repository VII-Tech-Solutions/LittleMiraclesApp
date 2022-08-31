//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/general/placeholder_image_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

enum ImageShape {
  square,
  rectangle,
}

class CachedImageWidget extends StatelessWidget {
  final int? index;
  final String? url;
  final ImageShape imageShape;
  final double? radius;
  final BoxFit? customBoxFit;
  final BorderRadius? borderRadius;
  const CachedImageWidget(
    this.index,
    this.url,
    this.imageShape, {
    this.radius = 8.0,
    this.customBoxFit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = PlaceholderImageWidget(
        index: index ?? 0,
        orientation:
            imageShape == ImageShape.square ? Axis.vertical : Axis.horizontal);
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0.0),
      child: CachedNetworkImage(
        imageUrl: url ?? '',
        maxHeightDiskCache: 800,
        maxWidthDiskCache: 800,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  }
}
