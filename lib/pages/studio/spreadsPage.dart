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

class SpreadsPage extends StatefulWidget {
  const SpreadsPage();

  @override
  _SpreadsPageState createState() => _SpreadsPageState();
}

class _SpreadsPageState extends State<SpreadsPage> {
  // List<int> _selectedItems = [];
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
    _selectedItem = context.read<Studio>().selectedSpreads;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.watch<AppData>();

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Spreads',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
        child: CustomScrollView(
          slivers: [
            SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1,
              children: appDataProvider
                  .getStudioMetadata(StudioMetaCategory.spreads)
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item.title ?? '',
                                  style: TextStyle(
                                    color: AppColors.black45515D,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  item.description ?? '',
                                  style: TextStyle(
                                    color: AppColors.black45515D,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
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
            )
          ],
        ),
      ),
      bottomNavigationBar: StudioBottomSectionContainer(
          btnLabel: 'Confirm Spreads',
          onTap: () {
            if (_selectedItem != null) {
              context.read<Studio>().assignSelectedSpec(
                  StudioMetaCategory.spreads, _selectedItem);
              Navigator.pop(context);
            } else {
              ShowOkDialog(context, 'Please select spreads to proceed');
            }
          }),
    );
  }
}
