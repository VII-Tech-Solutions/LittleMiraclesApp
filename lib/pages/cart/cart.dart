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
import '../../widgets/studioContainers/studioPaymentBottomContainer.dart';
import '../../widgets/studioContainers/studioPromoCodeContainer.dart';
import '../../widgets/studioContainers/studioPaymentContainer.dart';
import '../../widgets/containers/cartItemContainer.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/paymentContainer/paymentAgreement.dart';
import '../../widgets/studioContainers/studioSuccessPaymentPage.dart';
//PAGES

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final promoCode = context.watch<Studio>().promoCode;
    final cartItems = context.watch<Studio>().cartItems;
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
                children: cartItems
                    .map(
                      (e) => CartItemContainer(
                        description: e.description,
                        image: e.image,
                        price: e.price,
                        title: e.title,
                        onTapCallback: () {
                          context.read<Studio>().removeCartItem(e.id);
                        },
                      ),
                    )
                    .toList(),
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
            ),
            StudioPaymentContainer(isMultiSession: true, onTapCallback: (_) {}),
            PaymentAgreement(onTapCallback: (_) {})
            //TODO:: implement functionality
          ],
        ),
      ),
      bottomNavigationBar: StudioPaymentBottomContainer(
        onTapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudioSuccessPaymentPage('paymentMethod'),
            ),
          );
        },
      ),
    );
  }
}
