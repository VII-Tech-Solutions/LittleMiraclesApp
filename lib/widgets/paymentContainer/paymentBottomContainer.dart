//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class PaymentBottomContainer extends StatelessWidget {
  final VoidCallback? onTapCallback;
  final String? title;
  PaymentBottomContainer(
      {@required this.onTapCallback, this.title = 'Confirm & Pay'});

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final promoCode = context.watch<Bookings>().promoCode;

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
          Visibility(
            visible: promoCode?.code != null,
            child: Text(
              '- BD ${promoCode?.discountPrice ?? ''}',
              style: TextStyle(
                color: AppColors.redED0006,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'BD ${promoCode?.totalPrice ?? package?.price ?? ''}',
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
                title: title,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
