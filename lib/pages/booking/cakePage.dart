//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/texts/titleText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/question.dart';
import '../../models/cake.dart';
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessonContainers/selectionRow.dart';
import '../../widgets/general/cachedImageWidget.dart';

import '../../widgets/form/textQuestionWidget.dart';
//PAGES

class CakePage extends StatefulWidget {
  const CakePage({Key? key}) : super(key: key);

  @override
  _CakePageState createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {
  List<int> _selectedItems = [];
  // List<Cake> _selectedcakes = [];
  String _customCake = '';

  @override
  void initState() {
    final selectedList = context.read<Bookings>().selectedCakes;

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
    final allowedSelection = bookingsProvider.package!.cakeAllowed!;

    return Scaffold(
      appBar: AppBarWithBack(
        'Select Cake',
        weight: FontWeight.w800,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: appDataProvider.cakeCategories.length,
            itemBuilder: (BuildContext context, int index) {
              final int? catId = appDataProvider.cakeCategories[index].id;
              final String? title = appDataProvider.cakeCategories[index].name;
              if (appDataProvider.getCakesByCategoryId(catId!).isNotEmpty) {
                return _buildContainer(
                  title!,
                  Column(
                    children: appDataProvider
                        .getCakesByCategoryId(catId)
                        .map(
                          (item) => SelectionRow(() {
                            setState(() {
                              if (_selectedItems.contains(item.id)) {
                                _selectedItems.removeWhere(
                                    (element) => element == item.id);
                                // _selectedcakes.removeWhere(
                                //     (element) => element.id == item.id);
                              } else {
                                if (allowedSelection == 1) {
                                  _selectedItems.clear();
                                  // _selectedcakes.clear();
                                  _selectedItems.add(item.id!);
                                  // _selectedcakes.add(item);
                                } else if (allowedSelection > 1 &&
                                    allowedSelection == _selectedItems.length) {
                                  _selectedItems.removeAt(0);
                                  // _selectedcakes.removeAt(0);
                                  _selectedItems.add(item.id!);
                                  // _selectedcakes.add(item);
                                } else {
                                  _selectedItems.add(item.id!);
                                  // _selectedcakes.add(item);
                                }
                              }
                            });
                          },
                              item.image,
                              null,
                              item.title,
                              _selectedItems.contains(item.id),
                              bookingsProvider.package!.cakeAllowed!),
                        )
                        .toList(),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          TextQuestionWidget(
            Question(id: 1, question: 'Custom Cake'),
            (val) {
              if (val != null) {
                if (val['answer'] != '') {
                  _customCake = val['answer'];
                } else {
                  _customCake = '';
                }
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Additional charges may occur based on custom orders',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.black45515D,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: FilledButtonWidget(
          onPress: () {
            if (_selectedItems.isNotEmpty) {
              bookingsProvider.assignSelectedCakes(_selectedItems);
              Navigator.pop(context);
            } else {}
          },
          title: 'Confirm Cake',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
