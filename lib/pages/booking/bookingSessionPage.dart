//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
//MODELS
import '../../models/package.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            CalendarContainer(),
            AvailableTimeContainer(),
            JoiningPeopleContainer(),
            BackdropSelector(),
            CakeSelector(),
          ],
        ),
      ),
      bottomNavigationBar: PackageBottomSectionContainer(
        btnLabel: 'Next',
        onTap: () {
          final bookingsProvider = context.read<Bookings>();
        },
      ),
    );
  }
}
