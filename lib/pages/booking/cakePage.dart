//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/question.dart';
import '../../models/package.dart';
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessionContainers/selectionRow.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/form/textQuestionWidget.dart';
//PAGES

class CakePage extends StatefulWidget {
  final SubPackage? subPackage;
  final List<int>? subSessionSelectedCakes;
  const CakePage({this.subPackage, this.subSessionSelectedCakes});

  @override
  _CakePageState createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {
  List<int> _selectedItems = [];
  bool _isClearSelected = false;
  String _customCake = '';

  @override
  void initState() {
    List<int> selectedList = [];

    if (widget.subSessionSelectedCakes != null) {
      selectedList = widget.subSessionSelectedCakes!;
    } else {
      selectedList = context.read<Bookings>().selectedCakes;
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
        ? widget.subPackage!.cakeAllowed!
        : bookingsProvider.package!.cakeAllowed!;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Select Cake',
        weight: FontWeight.w800,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 30),
        children: [
          SelectionRow(
            () {
              setState(() {
                _selectedItems.clear();
                _isClearSelected = true;
              });
            },
            '',
            Container(
              decoration: BoxDecoration(
                color: AppColors.greyE8E9EB,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.do_not_disturb,
                size: 48,
                color: AppColors.black45515D,
              ),
            ),
            'No Cake',
            _isClearSelected,
            allowedSelection,
          ),
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
                          (item) => SelectionRow(
                            () {
                              setState(() {
                                _isClearSelected = false;
                                if (_selectedItems.contains(item.id)) {
                                  _selectedItems.removeWhere(
                                      (element) => element == item.id);
                                } else {
                                  if (allowedSelection == 1) {
                                    _selectedItems.clear();
                                    _selectedItems.add(item.id!);
                                  } else if (allowedSelection > 1 &&
                                      allowedSelection ==
                                          _selectedItems.length) {
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
                          ),
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
            Question(
              id: 1,
              question: 'Custom Cake',
              updatedAt: null,
              deletedAt: null,
              options: null,
              order: null,
              questionType: null,
            ),
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
            if (widget.subPackage != null) {
              Map<int, List<int>> cakesMap = {
                widget.subPackage!.id!: _selectedItems,
              };
              print('I CAME HERE POTATO: $cakesMap');
              bookingsProvider.amendSubSessionBookingDetails(
                SubSessionBookingDetailsType.cake,
                cakesMap,
              );
            } else {
              bookingsProvider.assignSelectedCakes(_selectedItems, _customCake);
            }
            Navigator.pop(context);
          },
          title: 'Confirm Cake',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
