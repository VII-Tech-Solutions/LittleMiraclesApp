//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/const.dart';
//MODELS
import '../../../models/session.dart';
//PROVIDERS
import '../../../providers/appData.dart';
import '../../../providers/bookings.dart';
//WIDGETS
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/bookingSessionContainers/calendarContainer.dart';
import '../../../widgets/bookingSessionContainers/availableTimeContainer.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
//PAGES

class BookAppointmentPage extends StatelessWidget {
  final Session? subSession;
  const BookAppointmentPage({this.subSession});

  @override
  Widget build(BuildContext context) {
    var date;
    var time;
    final sessionId = subSession != null
        ? subSession?.id
        : context.read<AppData>().session?.id;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Book an Appointment',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 0, bottom: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: CalendarContainer(
                onChangeCallback: (val) {
                  date = val?['date'];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AvailableTimeContainer(
                onChangeCallback: (val) {
                  time = val?['time'];
                },
              ),
            ),
            FilledButtonWidget(
              onPress: () {
                final appDataProvider = context.read<AppData>();
                final bookingsProvider = context.read<Bookings>();
                if (date == null) {
                  ShowOkDialog(context, 'Please select a date to proceed');
                } else if (time == null) {
                  ShowOkDialog(context, 'Please select a time to proceed');
                } else {
                  ShowLoadingDialog(context);
                  bookingsProvider
                      .bookAnAppointment(sessionId, date, time)
                      .then((response) {
                    final Session? session = bookingsProvider.session;

                    appDataProvider
                        .updateSessionDetails(session, subSession != null)
                        .then((_) {
                      ShowLoadingDialog(context, dismiss: true);
                      if (response?.statusCode == 200) {
                        ShowOkDialog(
                          context,
                          response?.message ??
                              'Your appointment booked successfully',
                          title: "Yaaay",
                          popWithAction: true,
                        );
                      } else {
                        ShowOkDialog(
                          context,
                          response?.message ?? ErrorMessages.somethingWrong,
                        );
                      }
                    });
                  });
                }
              },
              type: ButtonType.generalBlue,
              title: 'Confirm Date & Time',
              margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            ),
            FilledButtonWidget(
              onPress: () {
                Navigator.pop(context);
              },
              type: ButtonType.generalGrey,
              title: 'Cancel',
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            ),
          ],
        ),
      ),
    );
  }
}
