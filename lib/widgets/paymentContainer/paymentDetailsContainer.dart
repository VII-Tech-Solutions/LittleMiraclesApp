//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/texts/titleText.dart';
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
    final provider = context.watch<Bookings>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${provider.package?.tag ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black45515D,
              ),
            ),
          ),
          BenefitDetailsRow(
            '30 minutes in the studio',
            Icons.today,
          ),
          BenefitDetailsRow(
            '04:00 PM',
            Icons.access_time,
          ),
          BenefitDetailsRow(
            '1 baby, 2 adult',
            Icons.perm_identity_rounded,
          ),
          BenefitDetailsRow(
            'Pastel Rainbow Backdrop',
            Icons.wallpaper,
          ),
          BenefitDetailsRow(
            'Naked Cake - Pink',
            Icons.cake,
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
            'No Comments',
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
