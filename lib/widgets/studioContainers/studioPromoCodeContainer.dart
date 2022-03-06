//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/providers/studio.dart';
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../providers/bookings.dart';
import '../buttons/filledButtonWidget.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';

//EXTENSIONS

class StudioPromoCodeContainer extends StatefulWidget {
  const StudioPromoCodeContainer();

  @override
  State<StudioPromoCodeContainer> createState() =>
      _StudioPromoCodeContainerState();
}

class _StudioPromoCodeContainerState extends State<StudioPromoCodeContainer> {
  bool flip = false;
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
    final promoCode = context.watch<Studio>().promoCode;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: flip == false
                    ? MediaQuery.of(context).size.width * 0.914667
                    : MediaQuery.of(context).size.width * 0.78667,
                child: TextFormField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(height: 0),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 11.0),
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
              ),
              Visibility(
                  visible: flip,
                  child: IconButton(
                      onPressed: () {
                        _textFieldController.clear();
                        setState(() {
                          context.read<Studio>().removePromoCode();
                          flip = !flip;
                        });
                      },
                      icon: Icon(Icons.delete_outline)))
            ],
          ),
          // Visibility(
          //   visible: promoCode != null,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 6),
          //     child: Text(
          //       '${promoCode?.message ?? 'Promo code applied successfully'}',
          //       style: TextStyle(
          //         color: AppColors.green22D896,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w800,
          //       ),
          //     ),
          //   ),
          // ),
          Visibility(
            visible: !flip,
            child: FilledButtonWidget(
              // title: promoCode == null ? 'Apply' : 'Remove',
              title: 'Apply',
              onPress: () {
                if (_textFieldController.text.isNotEmpty) {
                  ShowLoadingDialog(context);
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    flip = !flip;
                  });
                  context
                      .read<Studio>()
                      .applyPromoCode(_textFieldController.text.toString())
                      .then((response) {
                    ShowLoadingDialog(context, dismiss: true);
                    // if (response?.statusCode != 200) {
                    //   ShowOkDialog(
                    //     context,
                    //     response?.message ?? ErrorMessages.somethingWrong,
                    //   );
                    // }
                  });
                } else {
                  _textFieldController.text = '';
                  context.read<Studio>().removePromoCode();
                }
              },
              type: ButtonType.generalGrey,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
            ),
          )
        ],
      ),
    );
  }
}
