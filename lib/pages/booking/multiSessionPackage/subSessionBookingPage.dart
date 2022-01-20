//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/texts/titleText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/const.dart';
//MODELS
import '../../../models/package.dart';
import '../../../models/question.dart';
//PROVIDERS
import '../../../providers/bookings.dart';
//WIDGETS
import '../../../widgets/dialogs/showOkDialog.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/form/textQuestionWidget.dart';
import '../../../widgets/bookingSessonContainers/cakeSelector.dart';
import '../../../widgets/bookingSessonContainers/backdropSelector.dart';
import '../../../widgets/bookingSessonContainers/calendarContainer.dart';
import '../../../widgets/bookingSessonContainers/availableLocationsContainer.dart';
import '../../../widgets/bookingSessonContainers/availableTimeContainer.dart';
import '../../../widgets/bookingSessonContainers/joiningPeopleContainer.dart';
import '../../../widgets/packageContainers/packageBottomSectionContainer.dart';
//PAGES
import '../../../pages/booking/photographerPage.dart';

class SubSessionBookingPage extends StatefulWidget {
  final SubPackage? package;
  const SubSessionBookingPage(this.package);

  @override
  State<SubSessionBookingPage> createState() => _SubSessionBookingPageState();
}

class _SubSessionBookingPageState extends State<SubSessionBookingPage> {
  @override

  // void deactivate() {
  //   context.read<Bookings>().resetBookingsData();
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.read<Bookings>();
    return Scaffold(
      appBar: AppBarWithBack(
        title: widget.package?.title ?? '',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: AppColors.pinkFCE0DC,
              alignment: Alignment.center,
              child: TitleText(
                title: widget.package?.description ?? '',
                customPadding: null,
                type: TitleTextType.secondaryTitle,
                weight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  CalendarContainer(
                    preSelectedDate: null,
                    onChangeCallback: (val) {
                      print(val);
                    },
                  ),
                  AvailableTimeContainer(
                    onChangeCallback: (val) {
                      print(val);
                    },
                  ),
                  JoiningPeopleContainer(),
                  BackdropSelector(),
                  CakeSelector(),
                ],
              ),
            ),
            FilledButtonWidget(
              onPress: () {},
              type: ButtonType.generalBlue,
              margin: const EdgeInsets.fromLTRB(16, 19, 16, 30),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: PackageBottomSectionContainer(
      //   btnLabel: 'Next',
      //   onTap: () {
      //     final timings = context.read<Bookings>().availableTimings;
      //     final bookingsBody = context.read<Bookings>().bookingsBody;
      //     if (bookingsBody.containsKey('location_link') &&
      //         bookingsBody['location_link'] == "") {
      //       ShowOkDialog(context, 'Please add the location link to proceed');
      //     } else if (!bookingsBody.containsKey('date')) {
      //       ShowOkDialog(context, 'Please select a date to proceed');
      //     } else if (!bookingsBody.containsKey('time') ||
      //         !timings.contains(bookingsBody['time'])) {
      //       ShowOkDialog(context, 'Please select a time to proceed');
      //     } else if (!bookingsBody.containsKey('people')) {
      //       ShowOkDialog(context, 'Please select people joining to proceed');
      //     } else if (!bookingsBody.containsKey('backdrops')) {
      //       ShowOkDialog(context, 'Please select a backdrop to proceed');
      //     } else {
      //       ShowLoadingDialog(context);
      //       // context.read<Bookings>().bookASession().then((response) {
      //       //   ShowLoadingDialog(context, dismiss: true);
      //       //   if (response?.statusCode == 200) {
      //       //     Navigator.push(
      //       //       context,
      //       //       MaterialPageRoute(
      //       //         builder: (context) => PhotographerPage(),
      //       //       ),
      //       //     );
      //       //   } else {
      //       //     ShowOkDialog(
      //       //       context,
      //       //       response?.message ?? ErrorMessages.somethingWrong,
      //       //     );
      //       //   }
      //       // });
      //     }
      //   },
      // ),
    );
  }
}
