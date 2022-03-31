//PACKAGES

// Flutter imports:
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
  Widget build(BuildContext context) {
    final photographers = context.watch<AppData>().photographers;
    final bookingsProvider = context.watch<Bookings>();

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Select Photographer',
        weight: FontWeight.w800,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: photographers.length,
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
            },
            photographers[index].image,
            null,
            photographers[index].name,
            _selectedItems.contains(photographers[index].id),
            1,
            id: index,
          );
        },
      ),
      bottomNavigationBar: widget.subPackage != null
          ? Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: FilledButtonWidget(
                onPress: () {
                  Map<int, List<int>> photographersMap = {
                    widget.subPackage!.id!: _selectedItems,
                  };
                  bookingsProvider.amendSubSessionBookingDetails(
                    SubSessionBookingDetailsType.photographer,
                    photographersMap,
                  );
                  Navigator.pop(context);
                },
                title: 'Confirm Photographer',
                type: ButtonType.generalBlue,
              ),
            )
          : PackageBottomSectionContainer(
              btnLabel: 'Next',
              onTap: () {
                if (_selectedItems.isEmpty) {
                  ShowOkDialog(
                      context, 'Please select a photographer to proceed');
                } else {
                  bookingsProvider.amendBookingBody(
                      {'photographer': _selectedItems.first}).then(
                    (_) {
                      ShowLoadingDialog(context);
                      context.read<Bookings>().removePromoCode();
                      context.read<Bookings>().bookASession().then(
                        (response) {
                          ShowLoadingDialog(context, dismiss: true);
                          if (response?.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewAndPayPage(),
                              ),
                            );
                          } else {
                            ShowOkDialog(
                              context,
                              response?.message ?? ErrorMessages.somethingWrong,
                            );
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
