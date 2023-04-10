//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../models/studioMetadata.dart';
import '../../providers/appData.dart';
import '../../providers/studio.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';

//EXTENSIONS

class PhotoPaperSizePage extends StatefulWidget {
  const PhotoPaperSizePage();

  @override
  _PhotoPaperSizePageState createState() => _PhotoPaperSizePageState();
}

class _PhotoPaperSizePageState extends State<PhotoPaperSizePage> {
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
    _selectedItem = context.read<Studio>().selectedPhotoPaperSize;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.watch<AppData>();
    final package = context.watch<Studio>().studioPackage;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Photo Paper Size',
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
                    text: 'Print Size ',
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
                  .getStudioMetadata(StudioMetaCategory.paperSize)
                  .map(
                    (item) => InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedItem?.id == item.id) {
                            _selectedItem = null;
                          } else {
                            _selectedItem = item;
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
                            decoration: _selectedItem?.id == item.id
                                ? _selectedDecoration
                                : _unselectedDecoration,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl: item.image ?? '',
                                      alignment: Alignment.topCenter,
                                      color: _selectedItem?.id == item.id
                                          ? AppColors.blueBBDCE0
                                          : AppColors.greyE8E9EB,
                                      errorWidget: (context, _, child) =>
                                          SizedBox(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  item.title ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black45515D,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _selectedItem?.id == item.id,
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
            ),
            SliverPadding(padding: const EdgeInsets.only(bottom: 30)),
          ],
        ),
      ),
      bottomNavigationBar: StudioBottomSectionContainer(
          title: 'Paper Size ${_selectedItem?.title ?? ''}',
          priceData: _selectedItem != null
              ? (double.parse(_selectedItem!.price.toString()) +
                      double.parse(package!.startingPrice.toString()))
                  .toString()
              : package!.startingPrice,
          btnLabel: 'Confirm Size',
          onTap: () {
            if (_selectedItem != null) {
              context.read<Studio>().assignSelectedSpec(
                  StudioMetaCategory.paperSize, _selectedItem);
              Navigator.pop(context);
            } else {
              ShowOkDialog(context, 'Please select a paper size to proceed');
            }
          }),
    );
  }
}
