//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../../widgets/bookingSessionContainers/sessionSelector.dart';
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../general/benefitDetailsRow.dart';

//EXTENSIONS

class BookingDetailsContainer extends StatelessWidget {
  const BookingDetailsContainer();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Twinkle Portrait Studio Session',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black45515D,
              ),
            ),
          ),

              Column(
                  children: [
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        '8th, January 2022',
                        Icons.today_outlined,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        '10:00 AM',
                        Icons.access_time,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        '2 baby, 1 adult',
                        Icons.perm_identity_rounded,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        '3 extra people joining',
                        Icons.perm_identity_rounded,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        'Pastel Rainbow Backdrop',
                        Icons.wallpaper,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        'Naked Cake - Pink',
                        Icons.cake_outlined,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: BenefitDetailsRow(
                        'Noni ',
                        Icons.photo_camera_outlined,
                        false,
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: EdgeInsets.only(top: 17, bottom: 6),
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
