//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../models/package.dart';
import '../../models/question.dart';
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessionContainers/selectionRow.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/textQuestionWidget.dart';

//EXTENSIONS

class BackdropType extends StatefulWidget {
  final SubPackage? subPackage;
  final List<int>? subSessionSelectedBackdrops;
  final index;
  const BackdropType(
      {this.subPackage, this.subSessionSelectedBackdrops, this.index});

  @override
  _BackdropTypeState createState() => _BackdropTypeState();
}

class _BackdropTypeState extends State<BackdropType> {
  List<int> _selectedItems = [];
  String _customBackdrop = '';

  @override
  void initState() {
    List<int> selectedList = [];

    if (widget.subSessionSelectedBackdrops != null) {
      selectedList = widget.subSessionSelectedBackdrops!;
    } else {
      selectedList = context.read<Bookings>().selectedBackdrops;
    }

    if (selectedList.isNotEmpty) {
      setState(() {
        _selectedItems = selectedList;
      });
    }
    super.initState();
  }

  Widget _buildContainer(String title, Widget childWidget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 15),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.black45515D,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        childWidget,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.watch<AppData>();
    final bookingsProvider = context.watch<Bookings>();
    final allowedSelection = widget.subPackage != null
        ? widget.subPackage!.backdropAllowed!
        : bookingsProvider.package!.backdropAllowed!;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Select Backdrop',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: appDataProvider
                    .getBackdropsByCategoryId(
                        appDataProvider.backdropCategories[widget.index].id!)
                    .map(
                      (item) => SelectionRow(
                        () {
                          setState(() {
                            if (_selectedItems.contains(item.id)) {
                              _selectedItems
                                  .removeWhere((element) => element == item.id);
                            } else {
                              if (allowedSelection == 1) {
                                _selectedItems.clear();
                                _selectedItems.add(item.id!);
                              } else if (allowedSelection > 1 &&
                                  allowedSelection == _selectedItems.length) {
                                _selectedItems.removeAt(0);
                                _selectedItems.add(item.id!);
                              } else {
                                _selectedItems.add(item.id!);
                              }
                            }
                          });
                        },
                        item.image,
                        null,
                        item.title,
                        _selectedItems.contains(item.id),
                        allowedSelection,
                        id: item.id,
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: TextQuestionWidget(
                Question(
                  id: 1,
                  question: 'Custom Backdrop',
                  updatedAt: null,
                  deletedAt: null,
                  options: null,
                  order: null,
                  questionType: null,
                ),
                (val) {
                  if (val != null) {
                    if (val['answer'] != '') {
                      _customBackdrop = val['answer'];
                    } else {
                      _customBackdrop = '';
                    }
                  }
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 5),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Additional charges may occur based on custom orders',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.black45515D,
                  ),
                ),
              ),
            ),
            SliverPadding(padding: const EdgeInsets.only(top: 30)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: FilledButtonWidget(
          onPress: () {
            print(bookingsProvider.package!.minBackdrop);
            print('muli');
            print(_selectedItems.length);
            if (_selectedItems.length < bookingsProvider.package!.minBackdrop &&
                bookingsProvider.package!.minBackdrop != null) {
              ShowOkDialog(context,
                  'Please select ${bookingsProvider.package!.minBackdrop} backdrop to proceed');
            } else {
              if (_selectedItems.isNotEmpty || _customBackdrop.isNotEmpty) {
                if (widget.subPackage != null) {
                  Map<int, List<int>> backdropsMap = {
                    widget.subPackage!.id!: _selectedItems,
                  };

                  bookingsProvider.amendSubSessionBookingDetails(
                    SubSessionBookingDetailsType.backdrop,
                    backdropsMap,
                  );
                } else {
                  bookingsProvider.assignSelectedBackdrops(
                      _selectedItems, _customBackdrop);
                }
                Navigator.pop(context);
              } else {
                ShowOkDialog(context, 'Please select a backdrop to proceed');
              }
            }
          },
          title: 'Confirm Backdrop',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
