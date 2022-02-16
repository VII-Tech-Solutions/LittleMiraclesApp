//PACKAGES
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/paymentContainer/studioPaymentBottomContainer.dart';
import '../../widgets/paymentContainer/studioPromoCodeContainer.dart';
import '../../widgets/containers/cartItem.dart';
import '../../widgets/appbars/appBarWithBack.dart';
//PAGES

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final promoCode = context.watch<Studio>().promoCode;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Shopping Cart',
        weight: FontWeight.bold,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  CartItem(),
                  CartItem(),
                  CartItem(),
                  CartItem(),
                  CartItem(),
                  CartItem(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.5),
              child: Divider(
                height: 1,
                thickness: 1,
              ),
            ),
            StudioPromoCodeContainer(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 29.5, 25, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                  Text(
                    'BD 333',
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 17,
              endIndent: 17,
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14.9, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VAT (5%)',
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                  Text(
                    '+BD 16.65',
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: promoCode != null,
              child: Column(
                children: [
                  Divider(
                    indent: 17,
                    endIndent: 17,
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14.9, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Promo code',
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: AppColors.black45515D,
                          ),
                        ),
                        Text(
                          '-BD ${promoCode?.discountPrice ?? 0}',
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: AppColors.black45515D,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            )

            //TODO:: ADD THE PAYMENT SECTION
          ],
        ),
      ),
      bottomNavigationBar: StudioPaymentBottomContainer(
        onTapCallback: () {},
      ),
    );
  }
}
