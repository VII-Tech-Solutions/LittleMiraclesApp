//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/studio.dart';
import '../buttons/filledButtonWidget.dart';

class StudioPaymentBottomContainer extends StatelessWidget {
  final VoidCallback? onTapCallback;
  final double? total;
  const StudioPaymentBottomContainer({
    @required this.onTapCallback,
    @required this.total,
  });

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
                  'BD $total',
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
