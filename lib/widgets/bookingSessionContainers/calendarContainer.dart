//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
//EXTENSIONS
import '../../extensions/dateTimeExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../providers/bookings.dart';
import '../../models/availableDates.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class CalendarContainer extends StatefulWidget {
  final bool isReschedule;
  final String? preSelectedDate;
  final void Function(Map?)? onChangeCallback;
  const CalendarContainer({
    this.isReschedule = false,
    this.preSelectedDate = null,
    this.onChangeCallback = null,
  });

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  DateTime firstDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  late final List<AvailableDates> _availableDate;

  @override
  void initState() {
    final provider = context.read<Bookings>();
    _availableDate = provider.availableDates;
    final firstDate = provider.availableDates.first.date;
    final preSelectedDate = widget.preSelectedDate;

    if (firstDate != null) {
      firstDay = DateTime.parse(firstDate);

      //set selected date
      if (preSelectedDate != null) {
        if (preSelectedDate.isNotEmpty) {
          selectedDay = DateTime.parse(preSelectedDate);
        } else {
          selectedDay = DateTime.parse(firstDate);
        }
      } else {
        selectedDay = DateTime.parse(firstDate);
      }

      //handle the calendar data
      if (widget.onChangeCallback != null) {
        widget.onChangeCallback!({'date': firstDate});
      } else {
        provider.amendBookingBody({'date': firstDate});
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<Bookings>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: widget.isReschedule == true
              ? 'Select your new date'
              : 'Select your date',
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
            firstDay: firstDay,
            focusedDay: selectedDay,
            lastDay: DateTime.utc(2030, 12, 31),
            availableGestures: AvailableGestures.horizontalSwipe,
            rowHeight: 45,
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
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                final formattedDate = selectedDay.toyyyyMMdd();
                provider.getAvailableTimings(formattedDate);

                if (widget.onChangeCallback != null) {
                  widget.onChangeCallback!({'date': formattedDate});
                } else {
                  provider.amendBookingBody({'date': formattedDate});
                }
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            enabledDayPredicate: (value) {
              String calendarDate = value.toyyyyMMdd();

              final list = _availableDate
                  .where((element) => element.date == calendarDate);

              return list.isEmpty ? false : true;
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
