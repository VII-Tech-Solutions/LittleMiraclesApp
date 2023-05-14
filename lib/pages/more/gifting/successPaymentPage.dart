//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/send_gift_page.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

import '../../../Global/colors.dart';
import '../../../providers/auth.dart';
import '../../../providers/giftingProvider.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../general/customBottomNavigationBar.dart';
import 'components/giftInfoContainer.dart';

//EXTENSIONS

class GiftSuccessPaymentPage extends StatelessWidget {
  final dynamic giftInformation;
  GiftSuccessPaymentPage(this.giftInformation);

  var authProvider;
  late GiftingData giftingProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<Auth>(context, listen: false);
    giftingProvider = Provider.of<GiftingData>(context, listen: false);

    // _confirmSignelSession(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            color: AppColors.greyF2F3F3,
            child: Icon(
              Icons.close,
              color: AppColors.black45515D,
              size: 24,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 26),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(giftInformation.toString()),
                Icon(
                  Icons.check_circle_rounded,
                  size: 100,
                  color: AppColors.green22D896,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Payment Successful',
                    style: TextStyle(
                      color: AppColors.green22D896,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'BD ${giftInformation['package_price']}',
                    // 'BD ${"promoCode"?.totalPrice ?? session!.subtotal ?? ''}',

                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Gift ID #${giftInformation['gift_id']}',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '${giftInformation['success_indicator'] == '' ? "Credit Card Payment" : "Debit Card Payment"} ',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.greyE8E9EB,
            margin: const EdgeInsets.only(top: 48.5, bottom: 15.5),
          ),
          GiftInfoContainer(giftInformation: giftInformation),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // margin: const EdgeInsets.only(bottom: 30),
          child: FilledButtonWidget(
            onPress: () async {
              ShowLoadingDialog(context);

              await giftingProvider.fetchUserGifts(authProvider.token);

              ShowLoadingDialog(context, dismiss: true);
              Navigator.of(context)
                ..pop()
                ..pop()
                ..pop()
                ..pop();
            },
            title: 'Go To Gift Details',
            type: ButtonType.generalBlue,
          ),
        ),
      ),
    );
  }
}
