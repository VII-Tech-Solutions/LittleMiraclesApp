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
import '../../../widgets/bookingSessionContainers/MultiSession/multiSessionPhotographerSelector.dart';
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
  Map<String, dynamic> _bookingBody = {};
  String? _preselectedDate;
  String? _preselectedTime;
  int _includeMe = 0;
  List<int?> _selectedPeople = [];

  // @override
  // void deactivate() {
  //   context.read<Bookings>().resetBookingsData();
  //   super.deactivate();
  // }

  Future<void> amendBookingBody(Map<String, dynamic>? data) async {
    _bookingBody.addAll({'sub_package_id': widget.subPackage?.id});

    if (data != null) _bookingBody.addAll(data);

    print(jsonEncode(_bookingBody));
  }

  @override
  void initState() {
    //fill preselected date and time and people
    final bookingsProvider = context.read<Bookings>();

    final map =
        bookingsProvider.getTemporaryBookedSubSession(widget.subPackage?.id);

    _preselectedDate = map?['date'];
    _preselectedTime = map?['time'];
    _includeMe = map?['include_me'] == true ? 1 : 0;
    if (map?['people'] != null) _selectedPeople = map!['people'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    final backdropsList = bookingsProvider.getSubSessionBookingDetails(
        SubSessionBookingDetailsType.backdrop, widget.subPackage!.id!);
    final cakesList = bookingsProvider.getSubSessionBookingDetails(
        SubSessionBookingDetailsType.cake, widget.subPackage!.id!);
    final photographersList = bookingsProvider.getSubSessionBookingDetails(
        SubSessionBookingDetailsType.photographer, widget.subPackage!.id!);
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
                    preSelectedDate: _preselectedDate,
                    onChangeCallback: (val) {
                      amendBookingBody(val);
                    },
                  ),
                  AvailableTimeContainer(
                    preSelectedTime: _preselectedTime,
                    onChangeCallback: (val) {
                      amendBookingBody(val);
                    },
                  ),
                  JoiningPeopleContainer(
                    includeMe: _includeMe,
                    selectedPeople: _selectedPeople,
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
                  MultiSessionPhotographerSelector(
                    widget.subPackage!,
                    photographersList,
                  ),
                ],
              ),
            ),
            FilledButtonWidget(
              onPress: () {
                if (backdropsList.isNotEmpty)
                  _bookingBody.addAll({'backdrops': backdropsList});

                if (cakesList.isNotEmpty)
                  _bookingBody.addAll({'cakes': cakesList});

                if (photographersList.isNotEmpty)
                  _bookingBody
                      .addAll({'photographer': photographersList.first});

                if (!_bookingBody.containsKey('date')) {
                  ShowOkDialog(context, 'Please select a date to proceed');
                } else if (!_bookingBody.containsKey('time')) {
                  ShowOkDialog(context, 'Please select a time to proceed');
                } else if (!_bookingBody.containsKey('people')) {
                  ShowOkDialog(
                      context, 'Please select people joining to proceed');
                } else if (!_bookingBody.containsKey('backdrops')) {
                  ShowOkDialog(context, 'Please select a backdrop to proceed');
                } else if (!_bookingBody.containsKey('photographer')) {
                  ShowOkDialog(
                      context, 'Please select a photographer to proceed');
                } else {
                  bookingsProvider.amendSubSessionBookingDetails(
                      SubSessionBookingDetailsType.subSession,
                      {widget.subPackage!.id!: _bookingBody});
                  bookingsProvider.amendMultiSessionBookingBody(null);
                  ShowLoadingDialog(context);
                  context.read<Bookings>().bookMultiSessions().then((response) {
                    ShowLoadingDialog(context, dismiss: true);
                    if (response?.statusCode == 200) {
                      Navigator.pop(context);
                    } else {
                      ShowOkDialog(
                        context,
                        response?.message ?? ErrorMessages.somethingWrong,
                      );
                    }
                  });
                }
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
