//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
import '../../models/media.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class ImageGridWidget extends StatelessWidget {
  final List<Media> media;
  const ImageGridWidget(this.media);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 32;
    return Container(
      width: size,
      height: size,
      child: Row(
        children: [
          Container(
            width: size * 0.592,
            child: Column(
              children: [
                Container(
                  height: size * 0.414,
                  child: CachedImageWidget(
                    media[0].url,
                    ImageShape.rectangle,
                    radius: 0.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: CachedImageWidget(
                    media[1].url,
                    ImageShape.square,
                    radius: 0.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: size * 0.592,
                  child: CachedImageWidget(
                    media[2].url,
                    ImageShape.square,
                    radius: 0.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    child: CachedImageWidget(
                      media[3].url,
                      ImageShape.square,
                      radius: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
