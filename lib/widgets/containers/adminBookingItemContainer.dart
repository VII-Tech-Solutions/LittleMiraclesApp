//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../../global/colors.dart';
import '../../models/media.dart';
import '../../widgets/general/cachedImageWidget.dart';

class AdminBookingItemContainer extends StatefulWidget {
  final String? image;
  final String? title;
  final String? description;
  final String? date;
  final String? time;
  final VoidCallback? onTapCallback;
  // final int? id;
  const AdminBookingItemContainer({
    Key? key,
    @required this.image,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.time,
    this.onTapCallback,
    // @required this.id,
  }) : super(key: key);

  @override
  State<AdminBookingItemContainer> createState() =>
      _AdminBookingItemContainerState();
}

class _AdminBookingItemContainerState extends State<AdminBookingItemContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapCallback,
      child: Container(
        height: 130,
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.pinkD9FEF2F1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                child: CachedImageWidget(
                  1, //TODO:: use the item ID instead of static
                  widget.image,
                  ImageShape.square,
                  radius: 20,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.date}',
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                        color: AppColors.black45515D,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        '${widget.title}',
                        style: TextStyle(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.black45515D,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${widget.time}',
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: AppColors.black45515D,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${widget.description}',
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: AppColors.black45515D,
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
