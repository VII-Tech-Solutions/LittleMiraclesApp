//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../pages/booking/multiSessionPackage/subSessionBookingPage.dart';
import '../../providers/bookings.dart';
import '../../widgets/texts/titleText.dart';
import '../dialogs/showOkDialog.dart';

//EXTENSIONS

class AvailableTimeContainer extends StatefulWidget {
  final String? preSelectedTime;
  final void Function(Map<String, dynamic>?)? onChangeCallback;
  final subPackage;
  const AvailableTimeContainer({
    this.preSelectedTime,
    this.onChangeCallback = null,
    this.subPackage,
  });

  @override
  State<AvailableTimeContainer> createState() => _AvailableTimeContainerState();
}

class _AvailableTimeContainerState extends State<AvailableTimeContainer> {
  String _selectedTime = "";

  @override
  void initState() {
    if (widget.preSelectedTime != null) {
      _selectedTime = widget.preSelectedTime!;
    }

    if (widget.onChangeCallback != null) {
      if (_selectedTime.isNotEmpty)
        widget.onChangeCallback!({'time': _selectedTime});
    }
    print('---preSelectedTime---$_selectedTime');

    super.initState();
  }

  // checkDate(sessionBody1, sessionBody2, sessionBody3) {
  //   var selectDate = SubPackageBody.subBookingBody['date'];
  //   print('-----datatttt----123--- ${selectDate}');
  //   bool dateSame = false;
  //   switch (widget.subPackage.id) {
  //     case 10:
  //       {
  //         if (sessionBody1 != null) if (sessionBody1.date.toString() ==
  //             selectDate.toString()) dateSame = true;
  //       }
  //       break;

  //     case 11:
  //       {
  //         if (sessionBody2 != null) if (sessionBody2.date
  //                 .toString()
  //                 .compareTo(selectDate.toString()) ==
  //             0) dateSame = true;
  //       }
  //       break;
  //     case 12:
  //       {
  //         if (sessionBody3 != null) if (sessionBody3.date
  //                 .toString()
  //                 .compareTo(selectDate.toString()) ==
  //             0) dateSame = true;
  //       }
  //       break;

  //     default:
  //       {
  //         dateSame = false;
  //       }
  //       break;
  //   }
  //   return dateSame;
  // }

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM') && !time.contains('12')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24,
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  getTime(startTime, endTime) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int EndTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
    int dif = EndTimeInt - startTimeInt;

    if (EndTimeInt > startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final availableTimes = context.watch<Bookings>().availableTimings;

    // if (widget.subPackage != null)
    //   SubPackageBody.subBookingBody['time'] == null ? _selectedTime = '' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'Available Times',
          type: TitleTextType.subTitleBlack,
          weight: FontWeight.w800,
          customPadding: const EdgeInsets.only(top: 20),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.greyD0D3D6,
              width: 1,
            ),
          ),
          child: availableTimes == [] || availableTimes.length == 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('No slots available'))
              : GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 28,
                    crossAxisCount: 3,
                  ),
                  itemCount: availableTimes.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () async {
//
                        final bookingsProvider = context.read<Bookings>();

                        // if (widget.subPackage != null) {
                        //   final map = context.read<Bookings>().bookingsBody;
                        //   final sessionBody1 =
                        //       bookingsProvider.getSubSessionBySubPackageId(5) ??
                        //           null;
                        //   final sessionBody2 = bookingsProvider
                        //           .getSubSessionBySubPackageId(10) ??
                        //       null;
                        //   final sessionBody3 = bookingsProvider
                        //           .getSubSessionBySubPackageId(11) ??
                        //       null;

                        //   var lastDate = widget.subPackage.id == 10
                        //       ? sessionBody1!.time
                        //       : widget.subPackage.id == 11
                        //           ? sessionBody2!.time
                        //           : widget.subPackage.id == 12
                        //               ? sessionBody3!.time
                        //               : null;

                        //   bool sameDate = await checkDate(
                        //       sessionBody1, sessionBody2, sessionBody3);
                        //   print('-----lastDate--' + sameDate.toString());
                        //   setState(() {
                        //     if (sameDate && map["sub_sessions"] != null) {
                        //       var t = fromString(lastDate!);
                        //       var s = fromString(availableTimes[index]);

                        //       var timeValue = getTime(t, s);

                        //       if (timeValue) {
                        //         _selectedTime = availableTimes[index];

                        //         if (widget.onChangeCallback != null) {
                        //           widget.onChangeCallback!(
                        //               {'time': _selectedTime});
                        //         } else {
                        //           context.read<Bookings>().amendBookingBody(
                        //               {'time': _selectedTime});
                        //         }
                        //       } else {
                        //         ShowOkDialog(context,
                        //             'Please select a future time to proceed');
                        //       }
                        // } else {
                        //   _selectedTime = availableTimes[index];

                        //   if (widget.onChangeCallback != null) {
                        //     widget
                        //         .onChangeCallback!({'time': _selectedTime});
                        //   } else {
                        //     context
                        //         .read<Bookings>()
                        //         .amendBookingBody({'time': _selectedTime});
                        //   }
                        // }
                        // });
                        // } else {
                        setState(() {
                          _selectedTime = availableTimes[index];

                          if (widget.onChangeCallback != null) {
                            widget.onChangeCallback!({'time': _selectedTime});
                          } else {
                            context
                                .read<Bookings>()
                                .amendBookingBody({'time': _selectedTime});
                          }
                        });
                        // }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTime == availableTimes[index]
                              ? AppColors.black2D3B48
                              : AppColors.greyF2F3F3,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          availableTimes[index],
                          style: TextStyle(
                            color: _selectedTime == availableTimes[index]
                                ? Colors.white
                                : AppColors.black45515D,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}
