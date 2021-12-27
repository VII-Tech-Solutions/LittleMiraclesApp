//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class TopContainer extends StatelessWidget {
  const TopContainer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Glimmer Newborn Studio Session',
          maxLines: 1,
          style: TextStyle(
            color: AppColors.black45515D,
            fontWeight: FontWeight.w800,
            fontSize: 18.0,
          ),
        ),
        Text(
          '01/08/2021',
          maxLines: 1,
          style: TextStyle(
            color: AppColors.black45515D,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
