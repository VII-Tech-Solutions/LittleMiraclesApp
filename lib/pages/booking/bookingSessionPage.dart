//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//EXTENSIONS
//GLOBAL
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/texts/titleText.dart';
import '../../widgets/bookingSessonContainers/availableTimeContainer.dart';
import '../../widgets/bookingSessonContainers/joiningPeopleContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/bookingSessonContainers/bottomContainer.dart';
//PAGES

class BookingSessionPage extends StatefulWidget {
  final Package? package;
  const BookingSessionPage(this.package);

  @override
  State<BookingSessionPage> createState() => _BookingSessionPageState();
}

class _BookingSessionPageState extends State<BookingSessionPage> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        'Reserve your session',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              title: 'Select your date',
              type: TitleTextType.subTitleBlack,
              weight: FontWeight.w800,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 12, 31),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  formatButtonVisible: false,
                  rightChevronIcon: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grey737C85,
                  ),
                  leftChevronIcon: Icon(
                    Icons.keyboard_arrow_left,
                    color: AppColors.grey737C85,
                  ),
                ),
                focusedDay: focusedDay,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDay, day);
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: false,
                  selectedDecoration: BoxDecoration(
                    color: AppColors.black45515D,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            //AvailableTimeContainer(),
            JoiningPeopleContainer(),
            BottomContainer(),
          ],
        ),
      ),
      bottomNavigationBar: PackageBottomSectionContainer(
        widget.package,
        btnLabel: 'Next',
        //TODO: change nav
      ),
    );
  }
}
