//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/question.dart';
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/bookingSessonContainers/selectionRow.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/form/textQuestionWidget.dart';
//PAGES

class BackdropPage extends StatefulWidget {
  const BackdropPage({Key? key}) : super(key: key);

  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<BackdropPage> {
  List<int> _selectedItems = [];
  String _customBackdrop = '';

  @override
  void initState() {
    final selectedList = context.read<Bookings>().selectedBackdrops;

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
    final allowedSelection = bookingsProvider.package!.backdropAllowed!;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Select Backdrop',
        weight: FontWeight.w800,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: appDataProvider.backdropCategories.length,
            itemBuilder: (BuildContext context, int index) {
              final int? catId = appDataProvider.backdropCategories[index].id;
              final String? title =
                  appDataProvider.backdropCategories[index].name;
              if (appDataProvider.getBackdropsByCategoryId(catId!).isNotEmpty) {
                return _buildContainer(
                  title!,
                  Column(
                    children: appDataProvider
                        .getBackdropsByCategoryId(catId)
                        .map(
                          (item) => SelectionRow(() {
                            setState(() {
                              if (_selectedItems.contains(item.id)) {
                                _selectedItems.removeWhere(
                                    (element) => element == item.id);
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
                              bookingsProvider.package!.backdropAllowed!),
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
              bookingsProvider.assignSelectedBackdrops(
                  _selectedItems, _customBackdrop);
              Navigator.pop(context);
            } else {
              ShowOkDialog(context, 'Please select a backrop to proceed');
            }
          },
          title: 'Confirm Backdrop',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
