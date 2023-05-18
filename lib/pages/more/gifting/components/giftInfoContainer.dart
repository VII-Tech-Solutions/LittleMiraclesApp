import 'package:flutter/material.dart';
import '../../../../global/colors.dart';
import '../../../../widgets/general/benefitDetailsRow.dart';

class GiftInfoContainer extends StatelessWidget {
  final giftInformation;

  const GiftInfoContainer({required this.giftInformation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: Text(
              'Send a Gift',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black45515D,
              ),
            ),
          ),
          BenefitDetailsRow(
            giftInformation['package_name'] +
                " " +
                giftInformation['package_tag'],
            Icons.card_giftcard,
            false,
            isLocation: false,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'To:',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              giftInformation['to'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'From:',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              giftInformation['from'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Message (optional):',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              giftInformation['message'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
