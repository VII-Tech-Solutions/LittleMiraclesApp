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
  final String? tag;
  final bool isLocation;
  const BenefitDetailsRow(this.content, this.icon,
      {this.tag, this.isLocation = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: AppColors.blue8DC4CB,
                size: 24.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16),
                  child: Text(
                    content,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: tag != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 16),
              child: Text(
                tag ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyB0A3A0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
