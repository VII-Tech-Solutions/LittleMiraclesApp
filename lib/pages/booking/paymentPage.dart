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
//PAGES

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Review & Pay',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              PaymentDetailsContainer(),
              Divider(
                color: AppColors.greyE8E9EB,
                thickness: 1,
              ),
              PromoCodeContainer(),
              Divider(
                color: AppColors.greyE8E9EB,
                thickness: 1,
              ),
              PaymentContainer(),
              PaymentAgreement(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PaymentBottomContainer(),
    );
  }
}
