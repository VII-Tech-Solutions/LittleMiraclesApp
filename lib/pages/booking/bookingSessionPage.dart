//PACKAGES
import '../../widgets/bookingSessonContainers/calendarContainer.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessonContainers/availableTimeContainer.dart';
import '../../widgets/bookingSessonContainers/joiningPeopleContainer.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/bookingSessonContainers/bottomContainer.dart';
//PAGES

class BookingSessionPage extends StatefulWidget {
  final Package? package;
  const BookingSessionPage(this.package);

  @override
  State<BookingSessionPage> createState() => _BookingSessionPageState();
}

class _BookingSessionPageState extends State<BookingSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        'Reserve your session',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarContainer(),
            AvailableTimeContainer(),
            JoiningPeopleContainer(),
            BottomContainer(),
          ],
        ),
      ),
      bottomNavigationBar: PackageBottomSectionContainer(
        widget.package,
        btnLabel: 'Next',
        //TODO: change nav
      ),
    );
  }
}
