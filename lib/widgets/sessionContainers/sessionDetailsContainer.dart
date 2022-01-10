//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../general/benefitDetailsRow.dart';
//PAGES

class SessionDetailsContainer extends StatelessWidget {
  final bool isReschedule;
  const SessionDetailsContainer({this.isReschedule = false});

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final package = context.watch<AppData>().package;
    final session = context.watch<AppData>().session;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: isReschedule == true
          ? const EdgeInsets.fromLTRB(16, 0, 16, 9.5)
          : null,
      decoration: isReschedule
          ? BoxDecoration(
              color: AppColors.pinkFCE0DC,
              border: Border.all(
                color: AppColors.greyD0D3D6,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 9.5),
          Visibility(
            visible: session?.formattedDate != null,
            child: BenefitDetailsRow(
              session?.formattedDate ?? '',
              Icons.today_outlined,
              isReschedule,
            ),
          ),
          Visibility(
            visible: session?.time != null,
            child: BenefitDetailsRow(
              session?.time ?? '',
              Icons.access_time,
              isReschedule,
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
                session?.locationText ?? '',
                Icons.camera_outdoor,
                isReschedule,
                description: session?.locationLink,
              ),
            ),
          ),
          Visibility(
            visible: session?.formattedPeople != null,
            child: BenefitDetailsRow(
              session?.formattedPeople ?? '',
              Icons.perm_identity_rounded,
              isReschedule,
            ),
          ),
          Visibility(
            visible: session?.formattedBackdrop != null,
            child: BenefitDetailsRow(
              session?.formattedBackdrop ?? '',
              Icons.wallpaper,
              isReschedule,
            ),
          ),
          Visibility(
            visible: session?.formattedCake != null,
            child: BenefitDetailsRow(
              session?.formattedCake ?? '',
              Icons.cake_outlined,
              isReschedule,
            ),
          ),
          Visibility(
            visible: session?.photographerName != null,
            child: BenefitDetailsRow(
              session?.photographerName ?? '',
              Icons.photo_camera_outlined,
              isReschedule,
            ),
          ),
          Visibility(
            visible: isReschedule == false,
            child: Padding(
              padding: const EdgeInsets.only(top: 17, bottom: 6),
              child: Text(
                'Additional Comments:',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isReschedule == false,
            child: Text(
              '${session?.comments ?? 'No Comments'}',
              style: TextStyle(
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
