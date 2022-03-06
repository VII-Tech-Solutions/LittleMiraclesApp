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

class StudioPaymentDetailsContainer extends StatelessWidget {
  const StudioPaymentDetailsContainer();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final subPackagesList = context.watch<Bookings>().subPackages;
    final session = context.watch<Bookings>().session;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${session?.title ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black45515D,
              ),
            ),
          ),
          subPackagesList.isNotEmpty
              ? Column(
                  children: subPackagesList
                      .map((subPackage) => SessionSelector(subPackage, false))
                      .toList(),
                )
              : Column(
                  children: [
                    Visibility(
                      visible: session?.formattedDate != null,
                      child: BenefitDetailsRow(
                        '${session?.formattedDate}',
                        Icons.today_outlined,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: session?.time != null,
                      child: BenefitDetailsRow(
                        '${session?.time}',
                        Icons.access_time,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: package?.outdoorAllowed == true,
                      child: InkWell(
                        onTap: () {
                          if (session?.locationLink != null) {
                            _launchURL('${session?.locationLink}');
                          }
                        },
                        child: BenefitDetailsRow(
                          '${session?.locationText}',
                          Icons.camera_outdoor,
                          false,
                          description: session?.locationLink,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: session?.formattedPeople != null,
                      child: BenefitDetailsRow(
                        '${session?.formattedPeople}',
                        Icons.perm_identity_rounded,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: session?.formattedBackdrop != null,
                      child: BenefitDetailsRow(
                        '${session?.formattedBackdrop}',
                        Icons.wallpaper,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: session?.formattedCake != null,
                      child: BenefitDetailsRow(
                        '${session?.formattedCake}',
                        Icons.cake_outlined,
                        false,
                      ),
                    ),
                    Visibility(
                      visible: session?.photographerName != null,
                      child: BenefitDetailsRow(
                        '${session?.photographerName}',
                        Icons.photo_camera_outlined,
                        false,
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: subPackagesList.isNotEmpty
                ? EdgeInsets.only(top: 10, bottom: 6)
                : EdgeInsets.only(top: 17, bottom: 6),
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
