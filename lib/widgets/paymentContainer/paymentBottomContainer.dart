//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class PaymentBottomContainer extends StatelessWidget {
  final VoidCallback? onTapCallback;
  const PaymentBottomContainer({@required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: AppColors.greyF2F3F3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BD 310',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          FilledButtonWidget(
            customWidth: 200,
            onPress: onTapCallback,
            type: ButtonType.generalBlue,
            title: 'Confirm & Pay',
          ),
        ],
      ),
    );
  }
}
