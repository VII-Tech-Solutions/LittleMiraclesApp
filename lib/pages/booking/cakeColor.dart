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

// class CakeColor extends StatefulWidget {
//   final SubPackage? subPackage;
//   final List<int>? subSessionSelectedCakes;
//   const CakeColor({this.subPackage, this.subSessionSelectedCakes});

//   @override
//   _CakeColorState createState() => _CakeColorState();
// }

// class _CakeColorState extends State<CakeColor> {
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
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/general/cachedImageWidget.dart';

//EXTENSIONS

class CakeColor extends StatefulWidget {
  final index;
  CakeColor({this.index});
  @override
  _CakeColorState createState() => _CakeColorState();
}

class _CakeColorState extends State<CakeColor> {
  List<int> _selectedItems = [];
  bool _isClearSelected = false;
  String _customCake = '';
  var selectedColor;

  @override
  void initState() {
    List<int> selectedList = [];

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

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Cake Color',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(),
            SliverToBoxAdapter(
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
                        'image',
                        ImageShape.square,
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
                              appDataProvider.cakeCategories[widget.index].name
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
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return SelectionRow(
                    () {
                      setState(() {
                        _isClearSelected = false;
                        selectedColor = appDataProvider.cakes[index].id;
                      });
                    },
                    appDataProvider.cakes[index].image,
                    null,
                    appDataProvider.cakes[index].title,
                    selectedColor == appDataProvider.cakes[index].id
                        ? true
                        : false,
                    1,
                    id: index,
                  );
                },
                childCount: appDataProvider.cakes.length,
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
            var cakes = [
              {
                'category_id': appDataProvider.cakeCategories[widget.index].id,
                'color_id': selectedColor
              }
            ];

            print(cakes);
            Navigator.pop(context, cakes);
          },
          title: 'Confirm Cake',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
