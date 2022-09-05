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
          final studioProvider = context.read<Studio>();
          if (studioProvider.selectedMedia.length > 0 &&
              studioProvider.selectedMedia.length <= count!) {
            String description = '';
            if (studioProvider.studioPackage?.id == 1) {
              description =
                  " ${studioProvider.selectedAlbumSize?.title}, ${studioProvider.selectedSpreads?.title}, ${studioProvider.selectedPaperType?.title}, ${studioProvider.selectedCoverType?.title}";
              print(
                  'id: ${studioProvider.studioBody['package_id']}, desc: $description');
            } else if (studioProvider.studioPackage?.id == 2) {
              description =
                  " ${studioProvider.selectedCanvasSize?.title}, ${studioProvider.selectedCanvasThickness?.title}, ${studioProvider.quantity}";
              print(
                  'id: ${studioProvider.studioBody['package_id']}, desc: $description');
            } else if (studioProvider.studioPackage?.id == 3) {
              description =
                  " ${studioProvider.selectedPrintType?.title}, ${studioProvider.selectedPhotoPaperSize?.title}, ${studioProvider.selectedPhotoPaperSize?.title}, ${studioProvider.selectedPaperType?.title}, ${studioProvider.quantity}";
              print(
                  'id: ${studioProvider.studioBody['package_id']}, desc: $description');
            }
            final package = studioProvider.studioPackage;
            String mediaIds = '';
            studioProvider.selectedMedia.forEach((element) {
              mediaIds = '$mediaIds,${element.id}';
            });
            mediaIds = mediaIds.replaceFirst(',', '');

            studioProvider.addToCart(
              {
                'package_id': package?.id,
                'package_type': package?.type,
                'title': package?.title,
                'description': description,
                'display_image': package?.image,
                'media_ids': mediaIds,
                'album_size': studioProvider.selectedAlbumSize?.id,
                'spreads': studioProvider.selectedSpreads?.id,
                'paper_type': studioProvider.selectedPaperType?.id,
                'cover_type': studioProvider.selectedCoverType?.id,
                'canvas_size': studioProvider.selectedCanvasSize?.id,
                'canvas_type': studioProvider.selectedCanvasSize?.id,
                'quantity': studioProvider.quantity,
                'print_type': studioProvider.selectedPrintType?.id,
                'paper_size': studioProvider.selectedPhotoPaperSize?.id,
                'additional_comment': studioProvider.additionalComment,
              },
            );

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CartPage(),
            //   ),
            // );
          } else if (studioProvider.selectedMedia.length <= 0) {
            ShowOkDialog(context, 'Please select at least one image');
          } else if (studioProvider.selectedMedia.length > count!) {
            ShowOkDialog(context, 'Please remove some images');
          }
        },
      ),
    );
  }
}
