//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class QuantitySelector extends StatefulWidget {
  const QuantitySelector();

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  List<int?> _selectedPeople = [];

  @override
  Widget build(BuildContext context) {
    final studioProvider = context.watch<Studio>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'Quantity',
          type: TitleTextType.secondaryTitle,
          weight: FontWeight.w400,
          customPadding: const EdgeInsets.only(top: 30),
        ),
        Container(
          height: 80,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.greyD0D3D6,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (studioProvider.quantity > 1)
                    studioProvider.assignQuantity(studioProvider.quantity - 1);
                },
                child: Icon(
                  Icons.do_not_disturb_on,
                  color: AppColors.black5C6671,
                  size: 38,
                ),
              ),
              Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: AppColors.greyE8E9EB,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Icon(
                        Icons.dashboard_outlined,
                        color: AppColors.greyA2A8AE,
                        size: 24.0,
                      ),
                    ),
                    Text(
                      '${studioProvider.quantity}',
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  studioProvider.assignQuantity(studioProvider.quantity + 1);
                },
                child: Icon(
                  Icons.add_circle,
                  color: AppColors.black5C6671,
                  size: 38,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
