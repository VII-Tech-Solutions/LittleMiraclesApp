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

class ReviewAndPayPage extends StatelessWidget {
  const ReviewAndPayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Review & Pay',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
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
              // margin: const EdgeInsets.only(top: 20),
            ),
            PaymentContainer(),
            PaymentAgreement(),
          ],
        ),
      ),
      bottomNavigationBar: PaymentBottomContainer(),
    );
  }
}
