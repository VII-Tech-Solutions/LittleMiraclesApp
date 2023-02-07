//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/general/placeholder_image_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';
import '../../widgets/general/cachedImageWidget.dart';

//EXTENSIONS

class SelectionRow extends StatelessWidget {
  final int? id;
  final VoidCallback onTap;
  final String? image;
  final Widget? customImage;
  final String? title;
  final String? subtitle;
  final bool? isSelected;
  final int allowedSelection;
  final int? maxline;
  final String? type;
  const SelectionRow(this.onTap, this.image, this.customImage, this.title,
      this.isSelected, this.allowedSelection,
      {required this.id, this.subtitle = null, this.maxline, this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: isSelected == true
            ? BoxDecoration(
                color: AppColors.blueF4F9FA,
                border: Border.all(
                  color: AppColors.blue8DC4CB,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
        child: Row(
          children: [
            // CircleAvatar(
            //           radius: 12,
            //           backgroundColor: Color(),

            //         ),
            SizedBox(
              height: 68,
              width: 68,
              child: customImage != null
                  ? customImage
                  : CachedImageWidget(
                      id,
                      image,
                      ImageShape.square,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black45515D),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle ?? '',
                        maxLines: maxline != null ? maxline : null,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey979797,
                        ),
                      )
                  ],
                ),
              ),
            ),
            allowedSelection > 1
                ? Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: isSelected == true
                          ? AppColors.blue8DC4CB
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.greyD0D3D6,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.greyD0D3D6,
                          width: 1,
                        )),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected == true
                            ? AppColors.blue8DC4CB
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
