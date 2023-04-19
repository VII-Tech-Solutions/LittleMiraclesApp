// Flutter imports:
import 'dart:convert';

import 'package:LMP0001_LittleMiraclesApp/models/package.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import '../../extensions/dateTimeExtension.dart';
import '../../global/colors.dart';
import '../../models/availableDates.dart';

import '../../pages/booking/multiSessionPackage/subSessionBookingPage.dart';
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

  getDate() {
    final provider = context.read<Bookings>();
    var date;
    switch (widget.subPackage.id) {
      case 5:
        {
          if (provider.availableDates.isNotEmpty) {
            date = provider.availableDates.first.date;
          } else {
            date = null;
          }
        }
        break;

      case 10:
        {
          final map = provider.getSubSessionBySubPackageId(5);
          // date = map!['date'];
          print('---map----$map');
          // if (provider.availableDates.isNotEmpty) {
          // date = provider.availableDates.first.date;

          for (int i = 0; i < _availableDate.length; i++) {
            _availableDate[i].date == map!.date && i + 1 < _availableDate.length
                ? date = _availableDate[i + 1].date
                : null;
          }
          // } else {
          //   date = null;
          // }
        }
        break;

      case 11:
        {
          final map = provider.getSubSessionBySubPackageId(10);
          // date = map!['date'];
          for (int i = 0; i < _availableDate.length; i++) {
            _availableDate[i].date == map!.date && i + 1 < _availableDate.length
                ? date = _availableDate[i + 1].date
                : null;
          }
        }
        break;
      case 12:
        {
          final map = provider.getSubSessionBySubPackageId(11);
          // date = map!['date'];
          for (int i = 0; i < _availableDate.length; i++) {
            _availableDate[i].date == map!.date && i + 1 < _availableDate.length
                ? date = _availableDate[i + 1].date
                : null;
          }
        }
        break;

      default:
        {
          if (provider.availableDates.isNotEmpty) {
            date = provider.availableDates.first.date;
          } else {
            date = null;
          }
        }
        break;
    }

    print('---id--${widget.subPackage.id}---date---$date');
    return date;
  }

  @override
  void initState() {
    final provider = context.read<Bookings>();
    _availableDate = provider.availableDates;
    var firstDate = null;
    if (widget.subPackage == null) {
      if (provider.availableDates.isNotEmpty) {
        firstDate = provider.availableDates.first.date;
      } else {
        firstDate = null;
      }
    } else {
      firstDate = getDate();
    }

    final preSelectedDate = widget.preSelectedDate;
    print('------perdate---$preSelectedDate');
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
      // provider.multidateSave(widget.subPackage.id, selectedDay);
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

                selectedDay =
                    DateTime.parse(selectDay.toString().replaceAll('Z', ''));
                if (widget.subPackage != null) {
                  provider.multidateSave(widget.subPackage.id, selectedDay);
                  print('------date---${selectedDay}');
                  print(bookingsProvider.bookingMultiDateBody1);
                  if (widget.subPackage.id == 10) {
                    if (bookingsProvider.bookingMultiDateBody1 !=
                        null) if (DateTime.parse(bookingsProvider
                                    .bookingMultiDateBody1
                                    .toString())
                                .compareTo(selectedDay) <
                            0 ||
                        DateTime.parse(bookingsProvider.bookingMultiDateBody1
                                    .toString())
                                .compareTo(selectedDay) ==
                            0) {
                      print('-----yes');
                    } else {
                      provider.multidateSave(widget.subPackage.id, null);
                      ShowOkDialog(
                          context, 'Please select a future date to proceed');
                    }
                  } else if (widget.subPackage.id == 11) {
                    if (bookingsProvider.bookingMultiDateBody2 !=
                        null) if (bookingsProvider.bookingMultiDateBody2!
                                .compareTo(
                                    DateTime.parse(selectedDay.toString())) <
                            0 ||
                        DateTime.parse(bookingsProvider.bookingMultiDateBody2
                                    .toString())
                                .compareTo(selectedDay) ==
                            0) {
                      print('yes');
                    } else {
                      provider.multidateSave(widget.subPackage.id, null);
                      ShowOkDialog(
                          context, 'Please select a future date to proceed');
                    }
                  } else if (widget.subPackage.id == 12) {
                    if (bookingsProvider.bookingMultiDateBody3 !=
                        null) if (bookingsProvider.bookingMultiDateBody3!
                                .compareTo(
                                    DateTime.parse(selectedDay.toString())) <
                            0 ||
                        DateTime.parse(bookingsProvider.bookingMultiDateBody3
                                    .toString())
                                .compareTo(selectedDay) ==
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
                  // if (widget.subPackage != null)
                  //   SubPackageBody.subBookingBody
                  //       .removeWhere((key, value) => key == "time");
                  widget.onChangeCallback!({'date': formattedDate});
                  // widget.onChangeCallback!(
                  //     {'date': formattedDate, 'time': '11:00 AM'});
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
