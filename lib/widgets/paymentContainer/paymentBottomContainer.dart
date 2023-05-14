//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/filledButtonWidget.dart';

class PaymentBottomContainer extends StatelessWidget {
  final type;
  final VoidCallback? onTapCallback;
  const PaymentBottomContainer({@required this.onTapCallback, this.type});

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final promoCode = context.watch<Bookings>().promoCode;
    final session = context.watch<Bookings>().session;
    final bookingsProvider = context.read<Bookings>();
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: promoCode?.code == null ? 100 : 123,
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
          //     ),How
          //   ),
          // ),
          if (type == 'final')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    // 'BD ${promoCode?.code != null ? session!.subtotal - int.parse(promoCode!.discountPrice!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")) : session!.subtotal}',

                    // 'BD ${promoCode?.code != null ? (promoCode.subtotal - double.parse(promoCode!.discountPrice!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), ""))).toStringAsFixed(2) : session!.subtotal}',
                    'BD ${promoCode?.code != null ? (promoCode?.subTotalPrice) : session!.subtotal}',

                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                FilledButtonWidget(
                  customWidth: 200,
                  onPress: bookingsProvider.paymentLink == null
                      ? null
                      : onTapCallback,
                  type: bookingsProvider.paymentLink == null
                      ? ButtonType.disable
                      : ButtonType.generalBlue,
                  title: 'Confirm & Pay',
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (package!.additionalCharge == 0)
                  Expanded(
                    child: Text(
                      'BD ${promoCode?.totalPrice! ?? package.price ?? ''}',
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Text(
                      'BD ${int.parse(package.price!.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")) + package.additionalCharge}',
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                FilledButtonWidget(
                  customWidth: 200,
                  onPress: bookingsProvider.paymentLink == null
                      ? null
                      : onTapCallback,
                  type: bookingsProvider.paymentLink == null
                      ? ButtonType.disable
                      : ButtonType.generalBlue,
                  title: 'Confirm & Pay',
                ),
              ],
            ),
        ],
      ),
    );
  }
}
