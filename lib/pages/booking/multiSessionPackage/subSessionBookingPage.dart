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
import '../../../widgets/form/textQuestionWidget.dart';
import '../../../widgets/bookingSessionContainers/MultiSession/multiSessionCakeSelector.dart';
import '../../../widgets/bookingSessionContainers/backdropSelector.dart';
import '../../../widgets/bookingSessionContainers/calendarContainer.dart';
import '../../../widgets/bookingSessionContainers/availableLocationsContainer.dart';
import '../../../widgets/bookingSessionContainers/availableTimeContainer.dart';
import '../../../widgets/bookingSessionContainers/joiningPeopleContainer.dart';
import '../../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/texts/titleText.dart';
//PAGES
import '../../../pages/booking/photographerPage.dart';

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
    final cakesList =
        bookingsProvider.getSubSessionBookingDetails(widget.subPackage!.id!);
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
                  BackdropSelector(),
                  MultiSessionCakeSelector(widget.subPackage!, cakesList),
                ],
              ),
            ),
            FilledButtonWidget(
              onPress: () {
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
    );
  }
}
