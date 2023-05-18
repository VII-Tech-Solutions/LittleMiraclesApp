//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';

//EXTENSIONS

class PromoCodeContainer extends StatefulWidget {
  const PromoCodeContainer();

  @override
  State<PromoCodeContainer> createState() => _PromoCodeContainerState();
}

class _PromoCodeContainerState extends State<PromoCodeContainer> {
  var code = '';
  late final _textFieldController;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final promoCode = context.watch<Bookings>().promoCode;

    if (promoCode != null) {
      _textFieldController.text = promoCode.code;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Promo Code',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          TextFormField(
            controller: _textFieldController,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyD0D3D6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyD0D3D6),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyD0D3D6),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              hintText: 'Enter Promo Code',
              hintStyle: TextStyle(
                color: AppColors.greyD0D3D6,
                fontSize: 12.0,
              ),
            ),
          ),
          Visibility(
            visible: promoCode != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${promoCode?.message ?? 'Promo code applied successfully'}',
                style: TextStyle(
                  color: AppColors.green22D896,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          FilledButtonWidget(
            title: promoCode == null ? 'Apply' : 'Remove',
            onPress: () {
              if (promoCode == null && _textFieldController.text.isNotEmpty) {
                ShowLoadingDialog(context);
                FocusManager.instance.primaryFocus?.unfocus();
                context
                    .read<Bookings>()
                    .applyPromoCode(_textFieldController.text.toString())
                    .then((response) {
                  ShowLoadingDialog(context, dismiss: true);
                  if (response?.statusCode != 200) {
                    ShowOkDialog(
                      context,
                      response?.message ?? ErrorMessages.somethingWrong,
                    );
                  }
                });
              } else {
                // context
                //     .read<Bookings>()
                //     .removePromoCodeBackend(promoCode!.code!);

                ShowLoadingDialog(context);
                FocusManager.instance.primaryFocus?.unfocus();
                context
                    .read<Bookings>()
                    .removePromoCodeBackend(promoCode!.code!)
                    .then((response) {
                  ShowLoadingDialog(context, dismiss: true);
                  if (response?.statusCode != 200) {
                    ShowOkDialog(
                      context,
                      response?.message ?? ErrorMessages.somethingWrong,
                    );
                  } else {
                    _textFieldController.text = '';
                  }
                });
              }
            },
            type: ButtonType.generalGrey,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
          )
        ],
      ),
    );
  }
}
