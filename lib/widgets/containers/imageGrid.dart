//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class ImageGridWidget extends StatelessWidget {
  final String image;
  const ImageGridWidget(this.image);

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
                    image,
                    ImageShape.rectangle,
                    radius: 0.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: CachedImageWidget(
                    image,
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
                    image,
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
                      image,
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
