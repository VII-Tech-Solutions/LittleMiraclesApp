//PACKAGES
import 'dart:math';

import 'package:LMP0001_LittleMiraclesApp/pages/studio/imagePicker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/session.dart';
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES

class PhotoSelectionContainer extends StatelessWidget {
  final Session session;
  const PhotoSelectionContainer(this.session);

  @override
  Widget build(BuildContext context) {
    final _random = new Random();
    final imagesList =
        context.read<AppData>().getSessionMedia(session.mediaIds);
    late final img1;
    late final img2;
    late final img3;

    final length = imagesList.length;
    if (length > 2) {
      img1 = imagesList[_random.nextInt(imagesList.length)].url;
      img2 = imagesList[_random.nextInt(imagesList.length)].url;
      img3 = imagesList[_random.nextInt(imagesList.length)].url;
    } else {
      img1 = img2 = img3 = '';
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePicker(session),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 343 / 249,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.blackD0D3D6),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 343 / 182,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(7)),
                        ),
                        child: CachedImageWidget(
                          img1,
                          ImageShape.square,
                          radius: 0,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 120 / 182,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                ),
                              ),
                              child: CachedImageWidget(
                                img2,
                                ImageShape.square,
                                radius: 0,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: CachedImageWidget(img3, ImageShape.square,
                                  radius: 0, borderRadius: BorderRadius.zero),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 10, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      session.title ?? '',
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 14, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      session.date.toString().toddMMMMyyyy(),
                      style: TextStyle(
                        color: AppColors.black737C85,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      '${imagesList.length}',
                      style: TextStyle(
                        color: AppColors.black737C85,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
