//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/models/package.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import '../../../../global/colors.dart';
import '../../../../widgets/buttons/filledButtonWidget.dart';

class PackageBottomBar extends StatelessWidget {
  final Package? selectedPackage;
  final String? price;

  final VoidCallback? onTap;
  const PackageBottomBar({this.onTap, this.selectedPackage, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        color: AppColors.greyF2F3F3,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: selectedPackage != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedPackage!.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 18,
                          ),
                        ),
                        if (selectedPackage!.additionalCharge != null &&
                            selectedPackage!.additionalCharge != 0)
                          Text(
                            'BD ${(double.parse(selectedPackage!.price!) + selectedPackage!.additionalCharge).toString()}',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        else
                          Text(
                            'BD ${selectedPackage!.price}',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        Text(
                          'Exclusive VAT',
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  FilledButtonWidget(
                    customWidth: 128,
                    onPress: onTap,
                    type: ButtonType.generalBlue,
                    title: 'Book Now',
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      price ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.black45515D,
                      ),
                    ),
                  ),
                  FilledButtonWidget(
                    customWidth: 200,
                    onPress: onTap,
                    type: ButtonType.generalBlue,
                    title: 'Confirm & Pay',
                  ),
                ],
              ));
  }
}
