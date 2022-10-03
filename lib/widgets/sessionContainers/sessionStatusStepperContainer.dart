//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../models/session.dart';
import '../../providers/appData.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSIONS

class SessionStatusStepperContainer extends StatelessWidget {
  final Session? subSession;
  const SessionStatusStepperContainer({this.subSession});

  _launchURL(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _stepper(bool condition, {bool hasLine = true}) {
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
                color: condition ? AppColors.blue8DC4CB : AppColors.greyD0D3D6,
                width: 1,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: condition ? AppColors.blue8DC4CB : Colors.white,
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
    final session = subSession ?? context.watch<AppData>().session;

    return Container(
      height: 422,
      width: double.infinity,
      padding: subSession != null
          ? null
          : const EdgeInsets.only(left: 18, right: 20),
      margin: subSession != null
          ? null
          : EdgeInsets.only(top: session?.hasGuideline == true ? 20 : 30),
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
                _stepper((session?.status ?? 0) >= 1),
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
                    onTap: () {
                      final dateAndTime = '${session?.date} ${session?.time}';

                      DateTime formattedDate =
                          DateFormat("yyyy-MM-dd h:mm a").parse(dateAndTime);

                      final Event event = Event(
                        title: session?.title ?? '',
                        location: session?.locationText ?? '',
                        startDate: formattedDate,
                        endDate: formattedDate,
                      );

                      Add2Calendar.addEvent2Cal(event);
                    },
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
                _stepper(
                  (isSameDay(
                          DateTime.now(),
                          (DateTime.tryParse(session?.date ?? '') ??
                              DateTime(0))) ||
                      (DateTime.tryParse(session?.date ?? '') ?? DateTime.now())
                          .isBefore(
                        DateTime.now(),
                      )),
                ),
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
                _stepper(
                  DateTime.now().isAfter(
                    (DateTime.tryParse(session?.date ?? '') ?? DateTime.now())
                        .add(
                      Duration(days: 1),
                    ),
                  ),
                ),
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
                _stepper(
                  DateTime.now().isAfter(
                    (DateTime.tryParse(session?.date ?? '') ?? DateTime.now())
                        .add(
                      Duration(days: 14),
                    ),
                  ),
                ),
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
                _stepper(
                    DateTime.now().isAfter(
                      (DateTime.tryParse(session?.date ?? '') ?? DateTime.now())
                          .add(
                        Duration(days: 28),
                      ),
                    ),
                    hasLine: false),
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
