//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../buttons/filledButtonWidget.dart';
//PAGES

class StudioPaymentBottomContainer extends StatelessWidget {
  final VoidCallback? onTapCallback;
  const StudioPaymentBottomContainer({@required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    // final package = context.watch<Studio>().package;
    // final promoCode = context.watch<Studio>().promoCode;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      // height: promoCode?.code == null ? 100 : 123,
      height: 100,
      width: double.infinity,
      color: AppColors.greyF2F3F3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility(
          //   visible: promoCode?.code != null,
          //   child: Text(
          //     '- BD ${promoCode?.discountPrice ?? ''}',
          //     style: TextStyle(
          //       color: AppColors.redED0006,
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'BD 349.65',
                  // 'BD ${promoCode?.totalPrice ?? package?.price ?? ''}',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              FilledButtonWidget(
                customWidth: 200,
                onPress: onTapCallback,
                type: ButtonType.generalBlue,
                title: 'Continue to Checkout',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
