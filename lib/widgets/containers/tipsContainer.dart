//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class TipsContainer extends StatelessWidget {
  final String? title;
  final String? url;
  const TipsContainer({Key? key, @required this.title, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        size.height * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.blue8DC4CB,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CachedNetworkImage(
                imageUrl: 'https://via.placeholder.com/300x300',
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 150,
                ),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 150,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '$title',
              maxLines: 1,
              style: TextStyle(
                color: AppColors.black45515D,
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9.0),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_rounded,
                  size: 16,
                  color: AppColors.yellowFFB400,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Tips & Tricks'.toUpperCase(),
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w200,
                      fontSize: 10.0,
                      letterSpacing: 1.0,
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
