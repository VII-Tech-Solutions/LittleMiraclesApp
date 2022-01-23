//PACKAGES
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/const.dart';
import '../../../global/colors.dart';
//MODELS
import '../../../models/package.dart';
import '../../../models/question.dart';
//PROVIDERS
import '../../../providers/bookings.dart';
//WIDGETS
import '../../../widgets/dialogs/showOkDialog.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/bookingSessionContainers/MultiSession/multiSessionCakeSelector.dart';
import '../../../widgets/bookingSessionContainers/MultiSession/multiSessionBackdropSelector.dart';
import '../../../widgets/bookingSessionContainers/calendarContainer.dart';
import '../../../widgets/bookingSessionContainers/availableTimeContainer.dart';
import '../../../widgets/bookingSessionContainers/joiningPeopleContainer.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/texts/titleText.dart';
//PAGES

class SubSessionBookingPage extends StatefulWidget {
  final SubPackage? subPackage;
  const SubSessionBookingPage(this.subPackage);

  @override
  State<SubSessionBookingPage> createState() => _SubSessionBookingPageState();
}

class _SubSessionBookingPageState extends State<SubSessionBookingPage> {
  Map _bookingBody = {};

  // @override
  // void deactivate() {
  //   context.read<Bookings>().resetBookingsData();
  //   super.deactivate();
  // }

  Future<void> amendBookingBody(Map? data) async {
    _bookingBody.addAll({'sub_package_id': widget.subPackage?.id});

    if (data != null) _bookingBody.addAll(data);

    print(jsonEncode(_bookingBody));
  }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    final backdropsList = bookingsProvider.getSubSessionBookingDetails(
        SubSessionBookingDetailsType.backdrop, widget.subPackage!.id!);
    final cakesList = bookingsProvider.getSubSessionBookingDetails(
        SubSessionBookingDetailsType.cake, widget.subPackage!.id!);
    return Scaffold(
      appBar: AppBarWithBack(
        title: widget.subPackage?.title ?? '',
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
                title: widget.subPackage?.description ?? '',
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
                      amendBookingBody(val);
                    },
                  ),
                  AvailableTimeContainer(
                    onChangeCallback: (val) {
                      amendBookingBody(val);
                    },
                  ),
                  JoiningPeopleContainer(
                    onChangeCallback: (val) {
                      amendBookingBody(val);
                    },
                  ),
                  MultiSessionBackdropSelector(
                    widget.subPackage!,
                    backdropsList,
                  ),
                  MultiSessionCakeSelector(
                    widget.subPackage!,
                    cakesList,
                  ),
                ],
              ),
            ),
            FilledButtonWidget(
              onPress: () {
                _bookingBody.addAll({'backdrops': backdropsList});
                _bookingBody.addAll({'cakes': cakesList});
                print(_bookingBody);
              },
              title: 'Confirm Session',
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
