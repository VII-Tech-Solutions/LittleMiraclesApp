// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/models/package.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import '../../extensions/dateTimeExtension.dart';
import '../../global/colors.dart';
import '../../models/availableDates.dart';
import '../../providers/bookings.dart';
import '../../widgets/texts/titleText.dart';
import '../dialogs/showOkDialog.dart';

class CalendarContainer extends StatefulWidget {
  final bool isReschedule;
  final String? preSelectedDate;
  final subPackage;
  final void Function(Map<String, dynamic>?)? onChangeCallback;
  const CalendarContainer({
    this.subPackage,
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
    final firstDate;
    if (provider.availableDates.isNotEmpty) {
      firstDate = provider.availableDates.first.date;
    } else {
      firstDate = null;
    }

    final preSelectedDate = widget.preSelectedDate;
    if (firstDate != null) {
      firstDay = DateTime.parse(firstDate);

      //set selected date
      if (preSelectedDate != null) {
        if (preSelectedDate.isNotEmpty) {
          selectedDay = DateTime.parse(preSelectedDate);
          provider.getAvailableTimings(preSelectedDate, withNotify: false);
        } else {
          selectedDay = DateTime.parse(firstDate);
          provider.getAvailableTimings(firstDate, withNotify: false);
        }
      } else {
        selectedDay = DateTime.parse(firstDate);
        provider.getAvailableTimings(firstDate, withNotify: false);
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
            lastDay: DateTime.now().add(Duration(days: 365)),
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
                final bookingsProvider = context.read<Bookings>();

                selectedDay = selectDay;
                if (widget.subPackage != null) {
                  provider.multidateSave(widget.subPackage.id, selectedDay);
                  if (widget.subPackage.id == 6) {
                    if (bookingsProvider.bookingMultiDateBody1 !=
                        null) if (bookingsProvider.bookingMultiDateBody1!
                            .compareTo(DateTime.parse(selectedDay.toString())) <
                        0) {
                      print('yes');
                    } else {
                      provider.multidateSave(widget.subPackage.id, null);
                      ShowOkDialog(
                          context, 'Please select a future date to proceed');
                    }
                  } else if (widget.subPackage.id == 7) {
                    if (bookingsProvider.bookingMultiDateBody2 !=
                        null) if (bookingsProvider.bookingMultiDateBody2!
                            .compareTo(DateTime.parse(selectedDay.toString())) <
                        0) {
                      print('yes');
                    } else {
                      provider.multidateSave(widget.subPackage.id, null);
                      ShowOkDialog(
                          context, 'Please select a future date to proceed');
                    }
                  } else if (widget.subPackage.id == 9) {
                    if (bookingsProvider.bookingMultiDateBody3 !=
                        null) if (bookingsProvider.bookingMultiDateBody3!
                            .compareTo(DateTime.parse(selectedDay.toString())) <
                        0) {
                      print('yes');
                    } else {
                      provider.multidateSave(widget.subPackage.id, null);
                      ShowOkDialog(
                          context, 'Please select a future date to proceed');
                    }
                  }
                }
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
