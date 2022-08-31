//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../../global/colors.dart';
import '../../models/media.dart';
import '../../widgets/general/cachedImageWidget.dart';

class CartItemContainer extends StatefulWidget {
  final String? image;
  final String? title;
  final String? description;
  final String? price;
  final VoidCallback? onTapCallback;
  // final int? id;
  const CartItemContainer({
    Key? key,
    @required this.image,
    @required this.description,
    @required this.price,
    @required this.title,
    this.onTapCallback,
    // @required this.id,
  }) : super(key: key);

  @override
  State<CartItemContainer> createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.blackD0D3D6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 68,
              height: 68,
              child: CachedImageWidget(
                1, //TODO:: use the item ID instead of static
                widget.image,
                ImageShape.square,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.52,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '${widget.title}\n',
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            color: AppColors.black45515D,
                          ),
                          children: [
                            TextSpan(
                              text: widget.description,
                              style: TextStyle(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: AppColors.black45515D,
                              ),
                            )
                          ]),
                    ),
                    Text(
                      'BD ${widget.price}',
                      style: TextStyle(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.black45515D,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: widget.onTapCallback,
            )
          ],
        ),
      ),
    );
  }
}
