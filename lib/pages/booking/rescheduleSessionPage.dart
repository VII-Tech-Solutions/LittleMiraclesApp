//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/const.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/sessionContainers/sessionDetailsContainer.dart';
import '../../widgets/bookingSessionContainers/calendarContainer.dart';
import '../../widgets/bookingSessionContainers/availableTimeContainer.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
//PAGES

class RescheduleSessionPage extends StatelessWidget {
  const RescheduleSessionPage();

  @override
  Widget build(BuildContext context) {
    var date;
    var time;
    final sessionId = context.read<AppData>().session?.id;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Reschedule Session',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 30),
        child: Column(
          children: [
            SessionDetailsContainer(isReschedule: true),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: CalendarContainer(
                onChangeCallback: (val) {
                  date = val;
                  print(date);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AvailableTimeContainer(
                onChangeCallback: (val) {
                  time = val;
                  print(time);
                },
              ),
            ),
            FilledButtonWidget(
              onPress: () {
                final appDataProvider = context.read<AppData>();
                final bookingsProvider = context.read<Bookings>();
                print(date);
                print(time);
                if (date == null) {
                  ShowOkDialog(context, 'Please select a date to proceed');
                } else if (time == null) {
                  ShowOkDialog(context, 'Please select a time to proceed');
                } else {
                  ShowLoadingDialog(context);
                  bookingsProvider
                      .rescheduleASession(sessionId, date, time)
                      .then((response) {
                    final session = bookingsProvider.session;

                    appDataProvider.updateSessionDetails(session).then((_) {
                      ShowLoadingDialog(context, dismiss: true);
                      if (response?.statusCode == 200) {
                        ShowOkDialog(
                          context,
                          response?.message ??
                              'Your session has been rescheduled',
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
