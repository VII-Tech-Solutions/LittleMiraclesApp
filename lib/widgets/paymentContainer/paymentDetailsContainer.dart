//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/sessionDetailsRow.dart';
//PAGES

class PaymentDetailsContainer extends StatelessWidget {
  const PaymentDetailsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Twinkle Portrait Studio Session',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.black45515D,
            ),
          ),
        ),
        SessionRowDetails(
          '30 minutes in the studio',
          Icons.today,
        ),
        SessionRowDetails(
          '04:00 PM',
          Icons.access_time,
        ),
        SessionRowDetails(
          '1 baby, 2 adult',
          Icons.perm_identity_rounded,
        ),
        SessionRowDetails(
          'Pastel Rainbow Backdrop',
          Icons.wallpaper,
        ),
        SessionRowDetails(
          'Naked Cake - Pink',
          Icons.cake,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Additional Comments:',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.black45515D,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
          child: Text(
            'No Comments',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.black45515D,
            ),
          ),
        ),
      ],
    );
  }
}
