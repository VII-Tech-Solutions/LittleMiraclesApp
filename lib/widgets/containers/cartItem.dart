//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';

//PAGES
class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 68,
              height: 68,
              child: CachedImageWidget(
                'https://i.picsum.photos/id/37/200/300.jpg?hmac=H-M0-zyAOZnQIHrggRUcDCS_roK8MHKI1OtEgZA72yk', //TODO:: Replace url
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
                          text: 'Twinkle Portrait Studio session\n',
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            color: AppColors.black45515D,
                          ),
                          children: [
                            TextSpan(
                              text: '8th January 2022',
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
                      'BD 160',
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
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}
