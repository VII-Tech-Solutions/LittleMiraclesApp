//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
//MODELS
import '../../models/package.dart';
import '../../models/question.dart';
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessonContainers/availableTimeContainer.dart';
import '../../widgets/bookingSessonContainers/joiningPeopleContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/bookingSessonContainers/calendarContainer.dart';
import '../../widgets/bookingSessonContainers/backdropSelector.dart';
import '../../widgets/bookingSessonContainers/cakeSelector.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
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
  Widget build(BuildContext context) {
    final bookingsProvider = context.read<Bookings>();
    return Scaffold(
      appBar: AppBarWithBack(
        'Reserve your session',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              CalendarContainer(),
              AvailableTimeContainer(),
              JoiningPeopleContainer(),
              BackdropSelector(),
              CakeSelector(),
              TextQuestionWidget(
                Question(id: 1, question: 'Additional Comments:'),
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
          final bookingsBody = context.read<Bookings>().bookingsBody;

          if (!bookingsBody.containsKey('date')) {
            ShowOkDialog(context, 'Please select a data to proceed');
          } else if (!bookingsBody.containsKey('time')) {
            ShowOkDialog(context, 'Please select a time to proceed');
          } else if (!bookingsBody.containsKey('people')) {
            ShowOkDialog(context, 'Please select people joining to proceed');
          } else if (!bookingsBody.containsKey('backdrops')) {
            ShowOkDialog(context, 'Please select a backdrop to proceed');
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotographerPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
