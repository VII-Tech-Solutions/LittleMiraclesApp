// Flutter imports:
import 'dart:collection';

import 'package:LMP0001_LittleMiraclesApp/widgets/admin/eventsModel.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import '../../extensions/dateTimeExtension.dart';
import '../../global/colors.dart';
import '../../models/availableDates.dart';
import '../../providers/bookings.dart';
import '../dialogs/showLoadingDialog.dart';

class CalendarContainer extends StatefulWidget {
  final bool isReschedule;
  final String? preSelectedDate;
  final void Function(Map<String, dynamic>?)? onChangeCallback;
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

// implemetation for adding dots on calander ...
  var kEvents;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

// booking privider ...
  bool isLoading = true;

  getAllBookings() {
    // ShowLoadingDialog(context);

    setState(() {
      isLoading = true;
    });
    final bookingsProvider = context.read<Bookings>();
    bookingsProvider.fetchAllAdminSessionDetails().then((value) => {
          setState(() {
            kEvents = value;
            isLoading = false;
          })
        });
    // ShowLoadingDialog(context, dismiss: true);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<Bookings>();
    final bookingsProvider = context.watch<Bookings>();

    // // event dots implementation ..
    // bookingsProvider.fetchAllAdminSessionDetails();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 7.5,
                    child: Container(
                      width: 4.5,
                      height: 4.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            date == selectedDay ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),

            eventLoader: isLoading ? null : _getEventsForDay,
            firstDay: firstDay.subtract(Duration(days: 365)),
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
                selectedDay = selectDay;
                final formattedDate = selectedDay.toyyyyMMdd();

                bookingsProvider.fetchAdminSessionDetails(
                  date: formattedDate,
                );
                print(formattedDate);
              });
              // bookingsProvider.fetchAllAdminSessionDetails();
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            // selectedDayPredicate: (day) {
            //   return isSameDay(selectedDay, day);
            // },
            // enabledDayPredicate: (value) {
            //   String calendarDate = value.toyyyyMMdd();
            //
            //   final list = _availableDate
            //       .where((element) => element.date == calendarDate);
            //
            //   return list.isEmpty ? false : true;
            // },
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
