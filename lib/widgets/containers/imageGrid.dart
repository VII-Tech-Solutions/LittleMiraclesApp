//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../models/media.dart';
import '../../widgets/general/cachedImageWidget.dart';

//EXTENSIONS

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
                    0,
                    media[0].url,
                    ImageShape.rectangle,
                    radius: 0.0,
                    customBoxFit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: CachedImageWidget(
                    1,
                    media[1].url,
                    ImageShape.square,
                    radius: 0.0,
                    customBoxFit: BoxFit.cover,
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
                    1,
                    media[2].url,
                    ImageShape.square,
                    radius: 0.0,
                    customBoxFit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    child: CachedImageWidget(
                      3,
                      media[3].url,
                      ImageShape.square,
                      radius: 0.0,
                      customBoxFit: BoxFit.cover,
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
