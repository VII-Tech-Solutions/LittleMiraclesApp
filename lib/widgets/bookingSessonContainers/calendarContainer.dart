//PACKAGES
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//EXTENSIONS
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
  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = DateTime.now();
    DateTime focusedDay = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'Select your date',
          type: TitleTextType.subTitleBlack,
          weight: FontWeight.w800,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
      ],
    );
  }
}
