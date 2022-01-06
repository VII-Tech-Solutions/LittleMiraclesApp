//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class SessionStatusStepperContainer extends StatelessWidget {
  const SessionStatusStepperContainer();

  _launchURL(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget _stepper(int? status, int step, {bool hasLine = true}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: status! >= step
                    ? AppColors.blue8DC4CB
                    : AppColors.greyD0D3D6,
                width: 1,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: status >= step ? AppColors.blue8DC4CB : Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Visibility(
            visible: hasLine,
            child: Container(
              width: 1,
              height: 70,
              color: AppColors.greyD0D3D6,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final package = context.watch<AppData>().package;
    final session = context.watch<AppData>().session;
    return Container(
      height: 422,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, right: 20),
      margin: EdgeInsets.only(top: session?.hasGuideline == true ? 20 : 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: TitleText(
              title: 'Progress',
              type: TitleTextType.subTitleBlack,
              weight: FontWeight.w800,
              customPadding: EdgeInsets.only(),
            ),
          ),
          Container(
            width: double.infinity,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepper(session?.status, 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      title: 'Session Booked',
                      type: TitleTextType.secondaryTitle,
                      weight: FontWeight.w800,
                      customPadding: EdgeInsets.zero,
                    ),
                    SizedBox(height: 3),
                    TitleText(
                      title:
                          '${session?.date.toString().toSlashddMMMyyyy() ?? ''}  •  ${session?.time ?? ''}',
                      type: TitleTextType.secondaryTitle,
                      weight: FontWeight.w400,
                      customPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.insert_invitation_outlined,
                          color: AppColors.blue8DC4CB,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'Add to Calendar',
                          style: TextStyle(
                            color: AppColors.blue8DC4CB,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepper(session?.status, 2),
                TitleText(
                  title: 'Photoshoot Day!',
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w800,
                  customPadding: EdgeInsets.zero,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (session?.isOutdoor == true) {
                        _launchURL(session?.locationLink);
                      } else {
                        _launchURL(package?.locationLink);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.place_outlined,
                          color: AppColors.blue8DC4CB,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'View location',
                          style: TextStyle(
                            color: AppColors.blue8DC4CB,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepper(session?.status, 3),
                TitleText(
                  title: 'Magic making in progress',
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w800,
                  customPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepper(session?.status, 4),
                TitleText(
                  title: 'Getting all your photos in order',
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w800,
                  customPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepper(session?.status, 5, hasLine: false),
                TitleText(
                  title: 'Your photos are ready!',
                  type: TitleTextType.secondaryTitle,
                  weight: FontWeight.w800,
                  customPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
