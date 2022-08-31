//PACKAGES

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/pages/cart/cartPage.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/studio.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/dialogs/showOkDialog.dart';
import '../../global/colors.dart';
import '../../providers/appData.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/containers/photoSelectionContainer.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';

//EXTENSIONS

class PhotoSelection extends StatelessWidget {
  const PhotoSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessions = context.watch<AppData>().completedSessions;
    final studio = context.watch<Studio>();
    final int? count;
    if (studio.studioBody.containsKey('spreads')) {
      print('not quantity');
      count = int.tryParse(studio.selectedSpreads?.description
              ?.replaceAll(RegExp(r'[^0-9\.]'), '') ??
          '');
    } else {
      count = studio.quantity;
    }
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Photo Selection',
        weight: FontWeight.w800,
      ),
      body: sessions.isEmpty
          ? SafeArea(
              child: Center(
                // TODO:: get the design and set the style
                child: Text("You don't have any completed sessions yet."),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
              child: Column(
                children:
                    sessions.map((e) => PhotoSelectionContainer(e)).toList(),
              ),
            ),
      bottomNavigationBar: StudioBottomSectionContainer(
        btnLabel: 'Add to Cart',
        showSlectedImages: true,
        onTap: () {
          final content = context.read<Studio>();
          if (content.selectedMedia.length > 0 &&
              content.selectedMedia.length <= count!) {
            String description = '';
            if (content.studioPackage?.id == 1) {
              description =
                  " ${content.selectedAlbumSize?.title}, ${content.selectedSpreads?.title}, ${content.selectedPaperType?.title}, ${content.selectedCoverType?.title}";
              print(
                  'id: ${content.studioBody['package_id']}, desc: $description');
            } else if (content.studioPackage?.id == 2) {
              description =
                  " ${content.selectedCanvasSize?.title}, ${content.selectedCanvasThickness?.title}, ${content.quantity}";
              print(
                  'id: ${content.studioBody['package_id']}, desc: $description');
            } else if (content.studioPackage?.id == 3) {
              description =
                  " ${content.selectedPrintType?.title}, ${content.selectedPhotoPaperSize?.title}, ${content.selectedPhotoPaperSize?.title}, ${content.selectedPaperType?.title}, ${content.quantity}";
              print(
                  'id: ${content.studioBody['package_id']}, desc: $description');
            }

            content.addCartItem(
              content.studioPackage?.title ?? '',
              description,
              content.packagePriceWithSpecs.toString(),
              content.studioPackage?.image ?? '',
              content.selectedMedia,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            );
          } else if (content.selectedMedia.length <= 0) {
            ShowOkDialog(context, 'Please select at least one image');
          } else if (content.selectedMedia.length > count!) {
            ShowOkDialog(context, 'Please remove some images');
          }
        },
      ),
    );
  }
}
