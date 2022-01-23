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
                    // media[0].url,
                    //TODO:: revert back to the old implementaion when the API/Admin is fixed
                    'https://i.picsum.photos/id/807/200/200.jpg?hmac=Y8gayvNItiQYxP_Pd-2un9GH09XuyJdIZOQPw6K9QsI',
                    ImageShape.rectangle,
                    radius: 0.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: CachedImageWidget(
                    // media[1].url,
                    //TODO:: revert back to the old implementaion when the API/Admin is fixed
                    'https://i.picsum.photos/id/986/200/200.jpg?hmac=Rqj6CXpaNxwumR7JjJGP9zm2AX92QkYPfNgufdAlpkY',
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
                    // media[2].url,
                    //TODO:: revert back to the old implementaion when the API/Admin is fixed
                    'https://i.picsum.photos/id/538/200/200.jpg?hmac=oJRLJPsN8ZdWjPpKGEU-oqAZMBKa4JsTnuUSqgRbyP4',
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
                      // media[3].url,
                      //TODO:: revert back to the old implementaion when the API/Admin is fixed
                      'https://i.picsum.photos/id/396/200/200.jpg?hmac=1OjJQ2_7SRz0wUfAkBJnIpcCn8IbJrSE5o3zG3T3tJY',
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
