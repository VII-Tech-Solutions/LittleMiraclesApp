//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class BenefitDetailsRow extends StatelessWidget {
  final String content;
  final IconData icon;
  const BenefitDetailsRow(
    this.content,
    this.icon,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.5),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.blue8DC4CB,
            size: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              content,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
