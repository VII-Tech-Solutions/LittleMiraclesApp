//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/const.dart';
import '../../models/question.dart';
import '../../pages/booking/photographerPage.dart';
import '../../providers/auth.dart';
import '../../providers/bookings.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessionContainers/availableLocationsContainer.dart';
import '../../widgets/bookingSessionContainers/availableTimeContainer.dart';
import '../../widgets/bookingSessionContainers/backdropSelector.dart';
import '../../widgets/bookingSessionContainers/cakeSelector.dart';
import '../../widgets/bookingSessionContainers/calendarContainer.dart';
import '../../widgets/bookingSessionContainers/joiningPeopleContainer.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';

//EXTENSIONS

class BookingSessionPage extends StatefulWidget {
  const BookingSessionPage();

  @override
  State<BookingSessionPage> createState() => _BookingSessionPageState();
}

class _BookingSessionPageState extends State<BookingSessionPage> {
  @override
  void deactivate() {
    context.read<Bookings>().resetBookingsData();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.read<Bookings>();
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Reserve your session',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              AvailableLocationContainer(),
              Visibility(
                  visible: context.read<Bookings>().availableDates.isNotEmpty,
                  child: CalendarContainer()),
              Visibility(
                  visible: context.read<Bookings>().availableTimings.isNotEmpty,
                  child: AvailableTimeContainer()),
              Visibility(
                visible: context.read<Auth>().isAuth == true,
                child: JoiningPeopleContainer(),
              ),
              BackdropSelector(),
              CakeSelector(),
              TextQuestionWidget(
                Question(
                  id: 1,
                  question: 'Additional Comments:',
                  updatedAt: null,
                  deletedAt: null,
                  options: null,
                  order: null,
                  questionType: null,
                ),
                (val) {
                  if (val != null) {
                    if (val['answer'] != '') {
                      bookingsProvider
                          .amendBookingBody({'comments': val['answer']});
                    } else {
                      bookingsProvider.amendBookingBody({'comments': ''});
                    }
                  }
                },
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
      bottomNavigationBar: PackageBottomSectionContainer(
        btnLabel: 'Next',
        onTap: () {
          if (context.read<Auth>().isAuth == true) {
            final timings = context.read<Bookings>().availableTimings;
            final bookingsBody = context.read<Bookings>().bookingsBody;
            if (bookingsBody.containsKey('location_link') &&
                bookingsBody['location_link'] == "") {
              ShowOkDialog(context, 'Please add the location link to proceed');
            } else if (!bookingsBody.containsKey('date')) {
              ShowOkDialog(context, 'Please select a date to proceed');
            } else if (!bookingsBody.containsKey('time') ||
                !timings.contains(bookingsBody['time'])) {
              ShowOkDialog(context, 'Please select a time to proceed');
            } else if (!bookingsBody.containsKey('people')) {
              ShowOkDialog(context, 'Please select people joining to proceed');
            } else if (!bookingsBody.containsKey('backdrops')) {
              ShowOkDialog(context, 'Please select a backdrop to proceed');
            } else {
              ShowLoadingDialog(context);
              context.read<Bookings>().bookASession().then((response) {
                ShowLoadingDialog(context, dismiss: true);
                if (response?.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotographerPage(),
                    ),
                  );
                } else {
                  ShowOkDialog(
                    context,
                    response?.message ?? ErrorMessages.somethingWrong,
                  );
                }
              });
            }
          } else {
            ShowOkDialog(context, 'Please login!');
          }
        },
      ),
    );
  }
}
