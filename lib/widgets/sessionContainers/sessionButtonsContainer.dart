//PACKAGES

// Flutter imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// Project imports:
import '../../extensions/dateTimeExtension.dart';
import '../../global/const.dart';
import '../../models/session.dart';
import '../../pages/booking/rescheduleSessionPage.dart';
import '../../pages/chat/chat.dart';
import '../../pages/chat/rooms.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../providers/bookings.dart';
import '../buttons/filledButtonWidget.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';

//EXTENSIONS

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
    final isAuth = context.read<Auth>().isAuth;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 46, 16, 25),
      child: Column(
        children: [
          FilledButtonWidget(
            onPress: () async {
              if (isAuth == true) {
                if (await FirebaseAuth.instance.currentUser?.uid ==
                    'o61U7RotNGb8ICAtjz3mShxsD802') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomsPage(),
                    ),
                  ).then((_) => ShowLoadingDialog(context, dismiss: true));
                } else {
                  final supportRoom =
                      await FirebaseChatCore.instance.createRoom(
                    types.User(id: 'o61U7RotNGb8ICAtjz3mShxsD802'),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(room: supportRoom),
                    ),
                  ).then((value) => ShowLoadingDialog(context, dismiss: true));
                }
              } else {
                ShowOkDialog(context, 'Please login!');
              }
            },
            title: 'Send a message',
            type: ButtonType.generalGrey,
          ),
          SizedBox(height: 10),
          Visibility(
            visible: canReschedule(context),
            child: FilledButtonWidget(
              onPress: () {
                ShowLoadingDialog(context);
                context
                    .read<Bookings>()
                    .fetchAndSetAvailableDates(subSession?.photographerId ?? -1)
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
