//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/paymentContainer/paymentDetailsContainer.dart';
import '../../widgets/paymentContainer/promoCodeContainer.dart';
import '../../widgets/paymentContainer/paymentContainer.dart';
import '../../widgets/paymentContainer/paymentBottomContainer.dart';
import '../../widgets/paymentContainer/paymentAgreement.dart';
import '../../widgets/dialogs/showOkDialog.dart';
//PAGES

class ReviewAndPayPage extends StatelessWidget {
  const ReviewAndPayPage();

  @override
  Widget build(BuildContext context) {
    bool _isAgreementChecked = false;
    int? _selectedPayment = null;
    final _scrollController = new ScrollController();

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Review & Pay',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 16, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentDetailsContainer(),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.greyE8E9EB,
                margin: const EdgeInsets.only(top: 20),
              ),
              PromoCodeContainer(),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.greyE8E9EB,
              ),
              PaymentContainer(
                onTapCallback: (val) {
                  _selectedPayment = val;
                },
              ),
              PaymentAgreement(onTapCallback: (val) {
                _isAgreementChecked = val;
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PaymentBottomContainer(
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
            //TODO:: go to payment page

          }
        },
      ),
    );
  }
}
