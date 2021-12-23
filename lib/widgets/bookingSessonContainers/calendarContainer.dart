//PACKAGES
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//EXTENSIONS
import '../../extensions/dateTimeExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({Key? key}) : super(key: key);

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'Select your date',
          type: TitleTextType.subTitleBlack,
          weight: FontWeight.w800,
          customPadding: EdgeInsets.zero,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
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
            availableGestures: AvailableGestures.horizontalSwipe,
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
            focusedDay: selectedDay,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            enabledDayPredicate: (value) {
              var now = new DateTime.now().add(Duration(days: 2));

              String excludedDate = now.toyyyyMMdd();
              String calendarDate = value.toyyyyMMdd();

              return calendarDate == excludedDate ? false : true;
            },
            calendarStyle: CalendarStyle(
              isTodayHighlighted: false,
              outsideDaysVisible: false,
              selectedDecoration: BoxDecoration(
                color: AppColors.black45515D,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
