//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/form/formTextField.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class PromoCodeContainer extends StatelessWidget {
  const PromoCodeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          TextField(
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
          FilledButtonWidget(
            title: 'Apply',
            onPress: () {},
            type: ButtonType.generalGrey,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
          )
        ],
      ),
    );
  }
}
