//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../general/benefitDetailsRow.dart';
//PAGES

class PaymentDetailsContainer extends StatelessWidget {
  const PaymentDetailsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final session = context.watch<Bookings>().session;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${package?.title ?? ''} ${package?.tag ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Visibility(
            visible: session?.formattedDate != null,
            child: BenefitDetailsRow(
              '${session?.formattedDate}',
              Icons.today_outlined,
            ),
          ),
          Visibility(
            visible: session?.time != null,
            child: BenefitDetailsRow(
              '${session?.time}',
              Icons.access_time,
            ),
          ),
          Visibility(
            visible: session?.formattedPeople != null,
            child: BenefitDetailsRow(
              '${session?.formattedPeople}',
              Icons.perm_identity_rounded,
            ),
          ),
          Visibility(
            visible: session?.formattedBackdrop != null,
            child: BenefitDetailsRow(
              '${session?.formattedBackdrop}',
              Icons.wallpaper,
            ),
          ),
          Visibility(
            visible: session?.formattedCake != null,
            child: BenefitDetailsRow(
              '${session?.formattedCake}',
              Icons.cake_outlined,
            ),
          ),
          Visibility(
            visible: session?.photographerName != null,
            child: BenefitDetailsRow(
              '${session?.photographerName}',
              Icons.photo_camera_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17, bottom: 6),
            child: Text(
              'Additional Comments:',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
              ),
            ),
          ),
          Text(
            '${session?.comments ?? 'No Comments'}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.black45515D,
            ),
          ),
        ],
      ),
    );
  }
}
