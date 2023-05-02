//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../models/package.dart';
import '../../../providers/appData.dart';
import '../../../providers/bookings.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/bookingSessionContainers/selectionRow.dart';
import '../../../widgets/form/formTextField.dart';
import '../../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../booking/photographerPage.dart';

//EXTENSIONS

class SelectPackage extends StatefulWidget {
  const SelectPackage();

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  List<int> _selectedItems = [];
  late Package selectedPackage;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SelectionRow(
                      () {
                        setState(() {
                          selectedPackage = _list[index];
                          _selectedItems.clear();
                          _selectedItems.add(index);
                        });
                        print("here .. ");
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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'To:',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 14,
                  ),
                ),
              ),
              FormTextFieldWidget(
                title: 'enter their email address',
                controller: TextEditingController(),
                maxLines: 1,
                customWidth: double.infinity,
                customMargin:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'From:',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 14,
                  ),
                ),
              ),
              FormTextFieldWidget(
                title: 'enter your name',
                controller: TextEditingController(),
                maxLines: 1,
                customWidth: double.infinity,
                customMargin:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Message (optional):',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 14,
                  ),
                ),
              ),
              FormTextFieldWidget(
                title: 'enter their email address',
                controller: TextEditingController(),
                maxLines: 5,
                customWidth: double.infinity,
                customMargin:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: PackageBottomSectionContainer(onTap: () {
      //   // print(selectedPackage.title);
      //   //     if (package?.id != null) {
      //   //   ShowLoadingDialog(context);
      //   //   context
      //   //       .read<Bookings>()
      //   //       .fetchAndSetPackageDetails(package!.id!)
      //   //       .then((response) {
      //   //     ShowLoadingDialog(context, dismiss: true);
      //   //     if (response.statusCode == 200) {
      //   //       Navigator.push(
      //   //         context,
      //   //         MaterialPageRoute(
      //   //           builder: (context) => PackageDetailsPage(),
      //   //         ),
      //   //       );
      //   //     } else {
      //   //       ShowOkDialog(
      //   //         context,
      //   //         response.message ?? ErrorMessages.somethingWrong,
      //   //       );
      //   //     }
      //   //   });
      //   // }
      //   // Navigator.of(context).push(
      //   //   MaterialPageRoute(
      //   //     builder: (context) => PhotographerPage(),
      //   //   ),
      //   // );
      // }),
    );
  }
}
