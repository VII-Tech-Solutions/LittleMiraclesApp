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

class PaperTypePage extends StatefulWidget {
  const PaperTypePage();

  @override
  _PaperTypePageState createState() => _PaperTypePageState();
}

class _PaperTypePageState extends State<PaperTypePage> {
  StudioMetadata? _selectedItem;

  @override
  void initState() {
    _selectedItem = context.read<Studio>().selectedPaperType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = context
        .watch<AppData>()
        .getStudioMetadata(StudioMetaCategory.paperType);

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Paper Type',
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
          btnLabel: 'Confirm Paper Type',
          onTap: () {
            if (_selectedItem != null) {
              context.read<Studio>().assignSelectedSpec(
                  StudioMetaCategory.paperType, _selectedItem);
              Navigator.pop(context);
            } else {
              ShowOkDialog(context, 'Please select paper type to proceed');
            }
          }),
    );
  }
}
