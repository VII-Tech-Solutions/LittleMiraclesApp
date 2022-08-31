//PACKAGES

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/pages/studio/imagePicker.dart';
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../models/session.dart';
import '../../providers/appData.dart';
import '../../providers/studio.dart';
import '../general/cachedImageWidget.dart';

//EXTENSIONS

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
    List<int> indices = [];

    if (imagesList.length > 2) {
      do {
        final value = _random.nextInt(imagesList.length);
        if (!indices.contains(value)) indices.add(value);
      } while (indices.length < 3);

      final length = indices.length;
      img1 = imagesList[indices[0]].url;
      img2 = imagesList[indices[1]].url;
      img3 = imagesList[indices[2]].url;
    } else {
      img1 = img2 = img3 = '';
    }

    final selectedImage =
        context.watch<Studio>().getSessionSelectedMedia(session.mediaIds);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePicker(session),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
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
                        1,
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
                              2,
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
                            child: CachedImageWidget(
                              3,
                              img3,
                              ImageShape.square,
                              radius: 0,
                              borderRadius: BorderRadius.zero,
                            ),
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
                    '${imagesList.length} Images',
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
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.greyD0D3D6,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedImage.length} Photo Selected',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: 32,
                    color: AppColors.black5C6671,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
