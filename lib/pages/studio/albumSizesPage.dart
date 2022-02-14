//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/studioMetadata.dart';
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
import '../../widgets/dialogs/showOkDialog.dart';
//PAGES

class AlbumSizePage extends StatefulWidget {
  const AlbumSizePage();

  @override
  _AlbumSizePageState createState() => _AlbumSizePageState();
}

class _AlbumSizePageState extends State<AlbumSizePage> {
  List<int> _selectedItems = [];
  StudioMetadata? _selectedItem;

  final _unselectedDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: AppColors.greyD0D3D6,
      width: 1,
    ),
  );

  final _selectedDecoration = BoxDecoration(
    color: AppColors.blueF4F9FA,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: AppColors.blueAFDADB,
      width: 1,
    ),
  );

  @override
  void initState() {
    List<int> selectedList = [];
    selectedList = context.read<Studio>().selectedAlbumSize;

    if (selectedList.isNotEmpty) {
      setState(() {
        _selectedItems = selectedList;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.watch<AppData>();
    final studioProvider = context.watch<Studio>();

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Album Size',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Album Size ',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black45515D,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '(inches)',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.normal,
                          color: AppColors.black45515D,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(padding: const EdgeInsets.only(top: 4)),
            SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 107 / 115,
              children: appDataProvider
                  .getStudioMetadata(StudioMetaCategory.albumSize)
                  .map(
                    (item) => InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedItems.contains(item.id)) {
                            _selectedItems.clear();
                          } else {
                            _selectedItems.clear();
                            _selectedItems.add(item.id!);
                          }
                        });
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.all(10),
                            decoration: _selectedItems.contains(item.id) == true
                                ? _selectedDecoration
                                : _unselectedDecoration,
                            child: Column(
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Container(
                                        //TODO:: add the image
                                        ),
                                  ),
                                ),
                                Text(
                                  item.title ?? '',
                                  style: TextStyle(
                                    color: AppColors.black45515D,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _selectedItems.contains(item.id) == true,
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.blue8DC4CB,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),

              //  List.generate(
              //   5,
              //   (index) => Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(
              //         color: AppColors.greyD0D3D6,
              //         width: 1,
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         Expanded(
              //           child: AspectRatio(
              //             aspectRatio: 1 / 1,
              //             child: Container(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //         Text(
              //           '16x24',
              //           style: TextStyle(
              //             color: AppColors.black45515D,
              //             fontWeight: FontWeight.w800,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            )
          ],
        ),
      ),
      bottomNavigationBar: StudioBottomSectionContainer(
          btnLabel: 'Confirm Size',
          onTap: () {
            if (_selectedItems.isNotEmpty) {
              // studioProvider.assignSelectedBackdrops(
              //     _selectedItems, _customBackdrop);

              Navigator.pop(context);
            } else {
              ShowOkDialog(context, 'Please select an album size to proceed');
            }
          }),
    );
  }
}
