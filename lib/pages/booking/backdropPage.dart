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
// import '../../widgets/dialogs/showOkDialog.dart';
// import '../../widgets/form/textQuestionWidget.dart';

// //EXTENSIONS

// class BackdropPage extends StatefulWidget {
//   final SubPackage? subPackage;
//   final List<int>? subSessionSelectedBackdrops;
//   const BackdropPage({this.subPackage, this.subSessionSelectedBackdrops});

//   @override
//   _BackdropPageState createState() => _BackdropPageState();
// }

// class _BackdropPageState extends State<BackdropPage> {
//   List<int> _selectedItems = [];
//   String _customBackdrop = '';

//   @override
//   void initState() {
//     List<int> selectedList = [];

//     if (widget.subSessionSelectedBackdrops != null) {
//       selectedList = widget.subSessionSelectedBackdrops!;
//     } else {
//       selectedList = context.read<Bookings>().selectedBackdrops;
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
//         ? widget.subPackage!.backdropAllowed!
//         : bookingsProvider.package!.backdropAllowed!;

//     return Scaffold(
//       appBar: AppBarWithBack(
//         title: 'Select Backdrop',
//         weight: FontWeight.w800,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: CustomScrollView(
//           slivers: [
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final int? catId =
//                       appDataProvider.backdropCategories[index].id;
//                   final String? title =
//                       appDataProvider.backdropCategories[index].name;
//                   if (appDataProvider
//                       .getBackdropsByCategoryId(catId!)
//                       .isNotEmpty) {
//                     return _buildContainer(
//                       title!,
//                       Column(
//                         children: appDataProvider
//                             .getBackdropsByCategoryId(catId)
//                             .map(
//                               (item) => SelectionRow(
//                                 () {
//                                   setState(() {
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
//                 childCount: appDataProvider.backdropCategories.length,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: TextQuestionWidget(
//                 Question(
//                   id: 1,
//                   question: 'Custom Backdrop',
//                   updatedAt: null,
//                   deletedAt: null,
//                   options: null,
//                   order: null,
//                   questionType: null,
//                 ),
//                 (val) {
//                   if (val != null) {
//                     if (val['answer'] != '') {
//                       _customBackdrop = val['answer'];
//                     } else {
//                       _customBackdrop = '';
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
//             SliverPadding(padding: const EdgeInsets.only(top: 30)),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 80,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         child: FilledButtonWidget(
//           onPress: () {
//             print(bookingsProvider.package!.minBackdrop);
//             print(_selectedItems.length);
//             if (_selectedItems.length < bookingsProvider.package!.minBackdrop &&
//                 bookingsProvider.package!.minBackdrop != null) {
//               ShowOkDialog(context,
//                   'Please select ${bookingsProvider.package!.minBackdrop} backdrop to proceed');
//             } else {
//               if (_selectedItems.isNotEmpty || _customBackdrop.isNotEmpty) {
//                 if (widget.subPackage != null) {
//                   Map<int, List<int>> backdropsMap = {
//                     widget.subPackage!.id!: _selectedItems,
//                   };
//                   bookingsProvider.amendSubSessionBookingDetails(
//                     SubSessionBookingDetailsType.backdrop,
//                     backdropsMap,
//                   );
//                 } else {
//                   bookingsProvider.assignSelectedBackdrops(
//                       _selectedItems, _customBackdrop);
//                 }
//                 Navigator.pop(context);
//               } else {
//                 ShowOkDialog(context, 'Please select a backdrop to proceed');
//               }
//             }
//           },
//           title: 'Confirm Backdrop',
//           type: ButtonType.generalBlue,
//         ),
//       ),
//     );
//   }
// }

//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/booking/backdropType.dart';
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
import '../../widgets/general/cachedImageWidget.dart';

//EXTENSIONS

class BackdropPage extends StatefulWidget {
  final SubPackage? subPackage;
  final List<int>? subSessionSelectedBackdrops;
  const BackdropPage({this.subPackage, this.subSessionSelectedBackdrops});

  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<BackdropPage> {
  List<int> _selectedItems = [];
  String _customBackdrop = '';
  List<Map> selectedBackdrop = [];
  bool? isSelected = false;

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
    print('-------${context.read<AppData>().backdropCategories}');
    print(
        '-----selectedBackdrops---${context.read<Bookings>().selectedBackdrops}');
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Backdrop Category'.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black737C85),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return bookingsProvider.package!.type !=
                              PackageType.miniSession &&
                          appDataProvider.backdropCategories[index].id == 6
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BackdropType(
                                      subPackage: widget.subPackage,
                                      index: index),
                                ),
                              );
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            // height: 75,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.greyD0D3D6,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              appDataProvider
                                                  .backdropCategories[index]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black162534),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                                Column(
                                  children: context
                                      .watch<AppData>()
                                      .getBackdropsByIds(
                                          bookingsProvider.selectedBackdrops)
                                      .map(
                                        (e) => Padding(
                                            padding:
                                                const EdgeInsets.symmetric(),
                                            child: e.categoryId ==
                                                    appDataProvider
                                                        .backdropCategories[
                                                            index]
                                                        .id
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: AppColors
                                                            .greyD0D3D6,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(children: [
                                                      SizedBox(
                                                        height: 48,
                                                        width: 48,
                                                        child:
                                                            CachedImageWidget(
                                                          e.id,
                                                          e.image,
                                                          ImageShape.square,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          child: Text(
                                                            e.title ?? '',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: AppColors
                                                                    .black45515D),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  )
                                                : Container()),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                },
                childCount: appDataProvider.backdropCategories.length,
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  isSelected = !isSelected!;
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade300),
                          child: Icon(
                            Icons.photo_outlined,
                            size: 50,
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Custom Backdrop'.toString(),
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
                            color: isSelected!
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
            if (bookingsProvider.selectedBackdrops.length <
                    bookingsProvider.package!.minBackdrop &&
                bookingsProvider.package!.minBackdrop != null) {
              ShowOkDialog(context,
                  'Please select ${bookingsProvider.package!.minBackdrop} backdrop to proceed');
            } else {
              // Navigator.pop(context);
              if (
                  // bookingsProvider.selectedBackdrops.isNotEmpty ||
                  _customBackdrop.isNotEmpty) {
                if (widget.subPackage != null) {
                  Map<int, List<int>> backdropsMap = {
                    widget.subPackage!.id!: _selectedItems,
                  };
                  bookingsProvider.amendSubSessionBookingDetails(
                    SubSessionBookingDetailsType.backdrop,
                    backdropsMap,
                  );
                } else {
                  bookingsProvider.assignSelectedBackdrops([], _customBackdrop);
                }
                Navigator.pop(context);
              } else if (bookingsProvider.selectedBackdrops.isNotEmpty) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                // ShowOkDialog(context, 'Please select a backdrop to proceed');
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
