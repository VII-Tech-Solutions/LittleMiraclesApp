//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/booking/bookingSessionPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/multiSessionPackage/multiSessionBookingPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/multiSessionPackage/subSessionBookingPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/chat/util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/src/provider.dart';

// Project imports:
import '../../global/const.dart';
import '../../models/package.dart';
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessionContainers/selectionRow.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import './reviewAndPayPage.dart';

//EXTENSIONS

class PhotographerPage extends StatefulWidget {
  final SubPackage? subPackage;
  final List<int>? subSessionSelectedPhotographer;
  const PhotographerPage(
      {this.subPackage, this.subSessionSelectedPhotographer});

  @override
  _PhotographerPageState createState() => _PhotographerPageState();
}

class _PhotographerPageState extends State<PhotographerPage> {
  List<int> _selectedItems = [];

  @override
  void initState() {
    // TODO: implement initState

    context.read<AppData>().photographers.forEach((element) {
      print('additional charge::::${element.additionalCharge}');
    });
    super.initState();
  }

  var indexs;

  @override
  Widget build(BuildContext context) {
    final photographers = context.watch<AppData>().photographers;
    final bookingsProvider = context.watch<Bookings>();
    final package = context.read<Bookings>().package;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Select Photographer',
        weight: FontWeight.w800,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/PlaceHolderStars.png'),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemCount: package!.id == 3 || package.id == 6 || package.id == 5
                ? 1
                : photographers.length,
            itemBuilder: (BuildContext context, int index) {
              return SelectionRow(
                () {
                  setState(() {
                    if (_selectedItems.contains(photographers[index].id)) {
                      _selectedItems.removeWhere(
                          (element) => element == photographers[index].id);
                    } else {
                      _selectedItems.clear();
                      _selectedItems.add(photographers[index].id!);
                    }
                  });
                  indexs = index;
                  if (package.id != 3 || package.id != 6 || package.id != 5)
                    package.additionalCharge =
                        photographers[indexs].additionalCharge != null &&
                                photographers[indexs].additionalCharge != 0 &&
                                photographers[indexs].additionalCharge != -1
                            ? photographers[indexs].additionalCharge
                            : 0;
                },
                photographers[index].image,
                null,
                photographers[index].name,
                _selectedItems.contains(photographers[index].id),
                1,
                id: index,
                subtitle: (package.id != 3 ||
                            package.id != 6 ||
                            package.id != 5 ||
                            package.id != 6 ||
                            package.subPackagesIds != 10) &&
                        photographers[index].additionalCharge != null &&
                        photographers[index].additionalCharge != 0 &&
                        photographers[index].additionalCharge != -1
                    ? '+BHD ${photographers[index].additionalCharge} (additional charge)'
                    : null,
              );
            },
          ),
          // Container(
          //   height: 120,
          //   padding: EdgeInsets.only(left: 10, right: 10),
          //   width: MediaQuery.of(context).size.width,
          //   child: Image(
          //     fit: BoxFit.cover,
          //     image: AssetImage('assets/images/PlaceHolderStars.png'),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar:
          // widget.subPackage != null
          //     ? Container(
          //         height: 80,
          //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //         child: FilledButtonWidget(
          //           onPress: () {
          //             Map<int, List<int>> photographersMap = {
          //               widget.subPackage!.id!: _selectedItems,
          //             };
          //             bookingsProvider.amendSubSessionBookingDetails(
          //               SubSessionBookingDetailsType.photographer,
          //               photographersMap,
          //             );
          //             Navigator.pop(context);
          //           },
          //           title: 'Confirm Photographer',
          //           type: ButtonType.generalBlue,
          //         ),
          //       )
          //     :
          PackageBottomSectionContainer(
        btnLabel: 'Next',
        onTap: () {
          print(_selectedItems);
          if (_selectedItems.isEmpty) {
            ShowOkDialog(context, 'Please select a photographer to proceed');
          } else {
            bookingsProvider
                .amendBookingBody({'photographer': _selectedItems.first}).then(
              (_) {
                package.additionalCharge =
                    photographers[indexs].additionalCharge != null &&
                            photographers[indexs].additionalCharge != 0 &&
                            photographers[indexs].additionalCharge != -1
                        ? photographers[indexs].additionalCharge
                        : 0;
                ShowLoadingDialog(context);
                context
                    .read<Bookings>()
                    .fetchAndSetAvailableDates(_selectedItems.first, null)
                    .then((response) {
                  ShowLoadingDialog(context, dismiss: true);
                  if (response?.statusCode == 200) {
                    if (package.type == PackageType.normalSession ||
                        package.type == PackageType.miniSession) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSessionPage(),
                        ),
                      );
                    } else {
                      Map<int, List<int>> photographersMap = {
                        widget.subPackage!.id!: _selectedItems,
                      };
                      bookingsProvider.amendSubSessionBookingDetails(
                        SubSessionBookingDetailsType.photographer,
                        photographersMap,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => MultiSessionBookingPage(),
                          builder: (context) =>
                              SubSessionBookingPage(widget.subPackage),
                        ),
                      );
                    }
                  } else {
                    ShowOkDialog(
                      context,
                      response?.message ?? ErrorMessages.somethingWrong,
                    );
                  }
                });

                // ShowLoadingDialog(context);
                // context.read<Bookings>().removePromoCode();
                // context.read<Bookings>().bookASession().then(
                //   (response) {
                //     ShowLoadingDialog(context, dismiss: true);
                //     if (response?.statusCode == 200) {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => ReviewAndPayPage(),
                //         ),
                //       );
                //     } else {
                //       ShowOkDialog(
                //         context,
                //         response?.message ?? ErrorMessages.somethingWrong,
                //       );
                //     }
                //   },
                // );
              },
            );
          }
        },
      ),
    );
  }
}
