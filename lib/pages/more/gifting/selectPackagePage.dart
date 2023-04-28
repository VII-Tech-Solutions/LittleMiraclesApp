//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../providers/appData.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/bookingSessionContainers/selectionRow.dart';

//EXTENSIONS

class SelectPackage extends StatefulWidget {
  const SelectPackage();

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  List<int> _selectedItems = [];
  String _customBackdrop = '';

  @override
  void initState() {
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
    final _list = context.watch<AppData>().packages;
    print(_list);
    // final bookingsProvider = context.watch<Bookings>();
    // final allowedSelection = widget.subPackage != null
    //     ? widget.subPackage!.backdropAllowed!
    //     : bookingsProvider.package!.backdropAllowed!;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Send a Gift',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 500,
          width: 400,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return SelectionRow(
                () {
                  // setState(() {
                  //   if (_selectedItems.contains(index)) {
                  //     _selectedItems
                  //         .removeWhere((element) => element == index);
                  //   } else {
                  //     _selectedItems.clear();
                  //     _selectedItems.add(index);
                  //   }
                  // });
                  // print("here .. ");
                },
                _list[index].image,
                null,
                _list[index].title,
                _selectedItems.contains(index),
                1,
                id: index,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // child: FilledButtonWidget(
        //   onPress: () {
        //     print(bookingsProvider.package!.minBackdrop);
        //     print('muli');
        //     print(_selectedItems.length);
        //     // if (_selectedItems.length < bookingsProvider.package!.minBackdrop &&
        //     //     bookingsProvider.package!.minBackdrop != null) {
        //     //   ShowOkDialog(context,
        //     //       'Please select ${bookingsProvider.package!.minBackdrop} backdrop to proceed');
        //     // } else {
        //     if (_selectedItems.isNotEmpty || _customBackdrop.isNotEmpty) {
        //       if (widget.subPackage != null) {
        //         Map<int, List<int>> backdropsMap = {
        //           widget.subPackage!.id!: _selectedItems,
        //         };

        //         bookingsProvider.amendSubSessionBookingDetails(
        //             SubSessionBookingDetailsType.backdrop, backdropsMap,
        //             selectedList: _selectedItems);
        //       } else {
        //         bookingsProvider.assignSelectedBackdrops(
        //             selectedList: _selectedItems, val: _customBackdrop);
        //       }
        //       Navigator.pop(context);
        //     } else {
        //       ShowOkDialog(context, 'Please select a backdrop to proceed');
        //     }
        //     // }
        //   },
        //   title: 'Confirm Package',
        //   type: ButtonType.generalBlue,
        // ),
      ),
    );
  }
}
