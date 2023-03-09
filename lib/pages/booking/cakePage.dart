// //PACKAGES

// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:provider/provider.dart';

// // Project imports:
// import '../../global/colors.dart';
// import '../../global/const.dart';
// import '../../models/package.dart';
// import '../../models/question.dart';
// import '../../providers/appData.dart';
// import '../../providers/bookings.dart';
// import '../../widgets/appbars/appBarWithBack.dart';
// import '../../widgets/bookingSessionContainers/selectionRow.dart';
// import '../../widgets/buttons/filledButtonWidget.dart';
// import '../../widgets/form/textQuestionWidget.dart';

// //EXTENSIONS

// class CakePage extends StatefulWidget {
//   final SubPackage? subPackage;
//   final List<int>? subSessionSelectedCakes;
//   const CakePage({this.subPackage, this.subSessionSelectedCakes});

//   @override
//   _CakePageState createState() => _CakePageState();
// }

// class _CakePageState extends State<CakePage> {
//   List<int> _selectedItems = [];
//   bool _isClearSelected = false;
//   String _customCake = '';

//   @override
//   void initState() {
//     List<int> selectedList = [];

//     if (widget.subSessionSelectedCakes != null) {
//       selectedList = widget.subSessionSelectedCakes!;
//     } else {
//       selectedList = context.read<Bookings>().selectedCakes;
//     }

//     if (selectedList.isNotEmpty) {
//       setState(() {
//         _selectedItems = selectedList;
//       });
//     }
//     super.initState();
//   }

//   Widget _buildContainer(String title, Widget childWidget) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 5, top: 15),
//           child: Text(
//             title,
//             style: TextStyle(
//               color: AppColors.black45515D,
//               fontSize: 18,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ),
//         childWidget,
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appDataProvider = context.watch<AppData>();
//     final bookingsProvider = context.watch<Bookings>();
//     final allowedSelection = widget.subPackage != null
//         ? widget.subPackage!.cakeAllowed!
//         : bookingsProvider.package!.cakeAllowed!;

//     return Scaffold(
//       appBar: AppBarWithBack(
//         title: 'Select Cake',
//         weight: FontWeight.w800,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final int? catId = appDataProvider.cakeCategories[index].id;
//                   final String? title =
//                       appDataProvider.cakeCategories[index].name;
//                   if (appDataProvider.getCakesByCategoryId(catId!).isNotEmpty) {
//                     return _buildContainer(
//                       title!,
//                       Column(
//                         children: appDataProvider
//                             .getCakesByCategoryId(catId)
//                             .map(
//                               (item) => SelectionRow(
//                                 () {
//                                   setState(() {
//                                     _isClearSelected = false;
//                                     if (_selectedItems.contains(item.id)) {
//                                       _selectedItems.removeWhere(
//                                           (element) => element == item.id);
//                                     } else {
//                                       if (allowedSelection == 1) {
//                                         _selectedItems.clear();
//                                         _selectedItems.add(item.id!);
//                                       } else if (allowedSelection > 1 &&
//                                           allowedSelection ==
//                                               _selectedItems.length) {
//                                         _selectedItems.removeAt(0);
//                                         _selectedItems.add(item.id!);
//                                       } else {
//                                         _selectedItems.add(item.id!);
//                                       }
//                                     }
//                                   });
//                                 },
//                                 item.image,
//                                 null,
//                                 item.title,
//                                 _selectedItems.contains(item.id),
//                                 allowedSelection,
//                                 id: index,
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     );
//                   } else {
//                     return Container();
//                   }
//                 },
//                 childCount: appDataProvider.cakeCategories.length,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: TextQuestionWidget(
//                 Question(
//                   id: 1,
//                   question: 'Custom Cake',
//                   updatedAt: null,
//                   deletedAt: null,
//                   options: null,
//                   order: null,
//                   questionType: null,
//                 ),
//                 (val) {
//                   if (val != null) {
//                     if (val['answer'] != '') {
//                       _customCake = val['answer'];
//                     } else {
//                       _customCake = '';
//                     }
//                   }
//                 },
//               ),
//             ),
//             SliverPadding(
//               padding: const EdgeInsets.only(top: 5),
//               sliver: SliverToBoxAdapter(
//                 child: Text(
//                   'Additional charges may occur based on custom orders',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: AppColors.black45515D,
//                   ),
//                 ),
//               ),
//             ),
//             SliverPadding(padding: const EdgeInsets.only(bottom: 30)),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 80,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         child: FilledButtonWidget(
//           onPress: () {
//             if (widget.subPackage != null) {
//               Map<int, List<int>> cakesMap = {
//                 widget.subPackage!.id!: _selectedItems,
//               };
//               bookingsProvider.amendSubSessionBookingDetails(
//                 SubSessionBookingDetailsType.cake,
//                 cakesMap,
//               );
//             } else {
//               bookingsProvider.assignSelectedCakes(_selectedItems, _customCake);
//             }
//             Navigator.pop(context);
//           },
//           title: 'Confirm Cake',
//           type: ButtonType.generalBlue,
//         ),
//       ),
//     );
//   }
// }

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/booking/cakeColor.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/general/cachedImageWidget.dart';

//EXTENSIONS

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
  String? isSelected;

  @override
  void initState() {
    var selectedList;

    if (widget.subSessionSelectedCakes != null) {
      selectedList = widget.subSessionSelectedCakes!;
    } else {
      selectedList = context.read<Bookings>().selectedCakes;
    }

    // if (selectedList.isNotEmpty) {
    //   setState(() {
    //     _selectedItems = selectedList;
    //   });
    // }
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

  var colorId;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isClearSelected = false;
                      });
                      colorId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CakeColor(index: index),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.greyD0D3D6,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 68,
                            width: 68,
                            child: CachedImageWidget(
                              1,
                              appDataProvider.cakeCategories[index].image,
                              ImageShape.square,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appDataProvider.cakeCategories[index].name
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.black45515D),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  );
                },
                childCount: appDataProvider.cakeCategories.length,
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  isSelected = 'nocake';
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.greyD0D3D6,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 68,
                        width: 68,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: '',
                            placeholder: (context, url) => Image.asset(
                              'assets/images/nocake.png',
                              fit: BoxFit.contain,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/nocake.png',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No Cake'.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.black45515D),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.greyD0D3D6,
                              width: 1,
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected == 'nocake'
                                ? AppColors.blue8DC4CB
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = 'custom';
                  });
                  print('------_customCake--$_customCake');
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.greyD0D3D6,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 68,
                        width: 68,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: '',
                            placeholder: (context, url) => Image.asset(
                              'assets/images/customcake.png',
                              fit: BoxFit.contain,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/customcake.png',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Custom cake'.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.black45515D),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.greyD0D3D6,
                              width: 1,
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected == 'custom'
                                ? AppColors.blue8DC4CB
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: TextQuestionWidget(
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
            SliverPadding(padding: const EdgeInsets.only(bottom: 30)),
          ],
        ),
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
              bookingsProvider.amendSubSessionBookingDetails(
                SubSessionBookingDetailsType.cake,
                cakesMap,
              );
              Navigator.pop(context);
            } else {
              print('----colorId----$colorId---$_customCake');
              print(
                  '----isSelected : ${isSelected.toString()}---: $_customCake');
              // bookingsProvider.assignSelectedCakes(_selectedItems, _customCake);
              if (isSelected == 'custom' && _customCake == '')
                ShowOkDialog(
                    context, 'Please add the custom cake details to proceed');
              else {
                bookingsProvider.assignSelectedCakes(
                    colorId == [] || colorId == null ? {} : colorId[0],
                    _customCake,
                    nocakes: isSelected == 'nocake' ? true : false);
                Navigator.pop(context);
              }
            }
          },
          title: 'Confirm Cake',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
