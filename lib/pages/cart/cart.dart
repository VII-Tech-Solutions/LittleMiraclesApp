//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/paymentContainer/paymentBottomContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/paymentContainer/promoCodeContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/containers/cartItem.dart';
import '../../widgets/appbars/appBarWithBack.dart';
//PAGES

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: ListView(
                      children: [
                        CartItem(),
                        CartItem(),
                        CartItem(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            PromoCodeContainer(),
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
          ],
        ),
      ),
      bottomNavigationBar: PaymentBottomContainer(
        onTapCallback: () {},
        title: 'Continue to Checkout',
      ),
    );
  }
}
