//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/bookingSessionContainers/selectionRow.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
//PAGES

class CoverTypePage extends StatefulWidget {
  const CoverTypePage();

  @override
  _CoverTypePageState createState() => _CoverTypePageState();
}

class _CoverTypePageState extends State<CoverTypePage> {
  StudioMetadata? _selectedItem;

  @override
  void initState() {
    _selectedItem = context.read<Studio>().selectedCoverType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = context
        .watch<AppData>()
        .getStudioMetadata(StudioMetaCategory.coverType);

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Cover Type',
        weight: FontWeight.w800,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        itemCount: list.length,
        itemBuilder: (context, index) => SelectionRow(
          () {
            setState(() {
              _selectedItem = list[index];
            });
          },
          list[index].image ?? '',
          null,
          list[index].title,
          _selectedItem == list[index],
          1,
        ),
      ),
      bottomNavigationBar: StudioBottomSectionContainer(
          title: 'Cover Type',
          btnLabel: 'Confirm Cover Type',
          onTap: () {
            if (_selectedItem != null) {
              context.read<Studio>().assignSelectedSpec(
                  StudioMetaCategory.coverType, _selectedItem);
              Navigator.pop(context);
            } else {
              ShowOkDialog(context, 'Please select cover type to proceed');
            }
          }),
    );
  }
}
