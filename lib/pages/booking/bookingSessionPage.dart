//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/const.dart';
//MODELS
import '../../models/package.dart';
import '../../models/question.dart';
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/bookingSessonContainers/cakeSelector.dart';
import '../../widgets/bookingSessonContainers/backdropSelector.dart';
import '../../widgets/bookingSessonContainers/calendarContainer.dart';
import '../../widgets/bookingSessonContainers/availableLocationsContainer.dart';
import '../../widgets/bookingSessonContainers/availableTimeContainer.dart';
import '../../widgets/bookingSessonContainers/joiningPeopleContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
//PAGES
import '../../pages/booking/photographerPage.dart';

class BookingSessionPage extends StatefulWidget {
  final Package? package;
  const BookingSessionPage(this.package);

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
              CalendarContainer(),
              AvailableTimeContainer(),
              JoiningPeopleContainer(),
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
          final timings = context.read<Bookings>().availableTimings;
          final bookingsBody = context.read<Bookings>().bookingsBody;
          if (bookingsBody.containsKey('location_link') &&
              bookingsBody['location_link'] == "") {
            ShowOkDialog(context, 'Please add the location link to proceed');
          } else if (!bookingsBody.containsKey('date')) {
            ShowOkDialog(context, 'Please select a data to proceed');
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
        },
      ),
    );
  }
}
