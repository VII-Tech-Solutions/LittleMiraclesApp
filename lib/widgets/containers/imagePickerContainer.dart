//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:LMP0001_LittleMiraclesApp/models/session.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/general/cachedImageWidget.dart';

//EXTENSIONS

class ImagePickerContainer extends StatelessWidget {
  final Media? media;
  final bool isSelected;
  const ImagePickerContainer(this.media, this.isSelected);

  @override
  Widget build(BuildContext context) {
    // final media = context.watch<AppData>();
    return AspectRatio(
      aspectRatio: 123 / 123,
      child: Stack(
        children: [
          CachedImageWidget(
            media?.url ?? '',
            ImageShape.square,
            borderRadius: BorderRadius.zero,
          ),
          Visibility(
            visible: isSelected == true,
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: EdgeInsets.zero,
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
                color: isSelected == true
                    ? AppColors.blue8DC4CB
                    : Color(0x80ffffff),
              ),
              child: Visibility(
                visible: isSelected == true,
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
