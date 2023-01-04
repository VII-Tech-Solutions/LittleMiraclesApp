//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showLoadingDialog.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../providers/studio.dart';
import '../../widgets/appbars/appBarWithBackandPop.dart';
import '../../widgets/containers/cartItemContainer.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/paymentContainer/paymentAgreement.dart';
import '../../widgets/studioContainers/studioPaymentBottomContainer.dart';
import '../../widgets/studioContainers/studioPaymentContainer.dart';
import '../../widgets/studioContainers/studioPromoCodeContainer.dart';
import '../../widgets/studioContainers/studioSuccessPaymentPage.dart';

//EXTENSIONS

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isAgreementChecked = false;
  bool _isLoading = false;
  String? _selectedPayment = null;
  final _scrollController = new ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _isLoading = true;
      });
      await context.read<Studio>().getCartItems();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _subtotal = 0;
    double _vat = 0;
    double _total = 0;
    // context.read<Studio>().getCartItemsDB();
    final promoCode = context.watch<Studio>().promoCode;
    final cartItems = context.watch<Studio>().cartItems;
    print(cartItems);
    return Scaffold(
      appBar: AppBarWithBackAndPop(
        title: 'Shopping Cart',
        weight: FontWeight.bold,
      ),
      body: Visibility(
        visible: cartItems.isNotEmpty,
        replacement: Center(
          heightFactor: 25,
          child: _isLoading == true
              ? CircularProgressIndicator.adaptive()
              : Text('Cart is empty.'),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: cartItems.map(
                    (e) {
                      return CartItemContainer(
                        description: e.description,
                        image: e.displayImage,
                        price: e.price,
                        title: e.title,
                        onTapCallback: () {
                          ShowLoadingDialog(context);
                          context.read<Studio>().removeCartItem(e.id).then(
                              (_) => ShowLoadingDialog(context, dismiss: true));
                        },
                      );
                    },
                  ).toList(),
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
                      'BD ${context.read<Studio>().cartSubtotal}',
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(16, 14.9, 20, 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'VAT (5%)',
              //         style: TextStyle(
              //           fontFamily: GoogleFonts.manrope().fontFamily,
              //           fontWeight: FontWeight.w800,
              //           fontSize: 14,
              //           color: AppColors.black45515D,
              //         ),
              //       ),
              //       Text(
              //         '+BD ${_vat.toStringAsFixed(1)}',
              //         style: TextStyle(
              //           fontFamily: GoogleFonts.manrope().fontFamily,
              //           fontWeight: FontWeight.w800,
              //           fontSize: 14,
              //           color: AppColors.black45515D,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
              StudioPaymentContainer(
                  isMultiSession: true,
                  onTapCallback: (val) => _selectedPayment = val),
              PaymentAgreement(
                  onTapCallback: (val) => _isAgreementChecked = val)
              //TODO:: implement functionality
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: cartItems.isNotEmpty,
        child: StudioPaymentBottomContainer(
          total: context.watch<Studio>().cartTotal,
          onTapCallback: () {
            if (_selectedPayment == null) {
              ShowOkDialog(context, 'Please select a payment method');
            } else if (_isAgreementChecked == false) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            } else {
              ShowLoadingDialog(context);
              context.read<Studio>().checkOut().then((value) {
                ShowLoadingDialog(context, dismiss: true);
                if (value != 'Order created successfully') {
                  ShowOkDialog(
                    context,
                    value ?? ErrorMessages.somethingWrong,
                  );
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              });
            }
          },
        ),
      ),
    );
  }
}
