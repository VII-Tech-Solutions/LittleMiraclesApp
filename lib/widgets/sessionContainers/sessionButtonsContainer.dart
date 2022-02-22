//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../../extensions/dateTimeExtension.dart';
//GLOBAL
import '../../global/const.dart';
//MODELS
import '../../models/session.dart';
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../buttons/filledButtonWidget.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';
//PAGES
import '../../pages/booking/rescheduleSessionPage.dart';

class SessionButtonContainer extends StatelessWidget {
  final Session? subSession;
  const SessionButtonContainer({this.subSession});

  bool canReschedule(BuildContext context) {
    bool canReschedule = false;

    Session? session = subSession ?? context.read<AppData>().session;

    final date = session?.date;

    if (date != null) {
      final sessionDate = DateTime.parse(date);
      final currentDate = DateTime.parse(DateTime.now().toyyyyMMdd());

      final difference = sessionDate.difference(currentDate).inDays;

      if (difference > 2) {
        canReschedule = true;
      }
    }

    return canReschedule;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 46, 16, 25),
      child: Column(
        children: [
          //TODO:: uncomment when the chat is ready
          // FilledButtonWidget(
          //   onPress: () {},
          //   title: 'Send a message',
          //   type: ButtonType.generalGrey,
          // ),
          SizedBox(height: 10),
          Visibility(
            visible: canReschedule(context),
            child: FilledButtonWidget(
              onPress: () {
                ShowLoadingDialog(context);
                context
                    .read<Bookings>()
                    .fetchAndSetAvailableDates()
                    .then((response) {
                  ShowLoadingDialog(context, dismiss: true);
                  if (response?.statusCode == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RescheduleSessionPage(
                          subSession: subSession,
                        ),
                      ),
                    );
                  } else {
                    ShowOkDialog(
                      context,
                      response?.message ?? ErrorMessages.somethingWrong,
                    );
                  }
                });
              },
              title: 'Reschedule Session',
              type: ButtonType.generalBlue,
            ),
          ),
        ],
      ),
    );
  }
}
