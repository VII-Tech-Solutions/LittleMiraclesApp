//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/models/session.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/auth.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/studio.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/containers/imagePickerBottomContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../global/colors.dart';
import '../../models/media.dart';
import '../../providers/appData.dart';
import '../../widgets/appbars/appBarWithClose.dart';
import '../../widgets/containers/imagePickerContainer.dart';

class ImagePicker extends StatefulWidget {
  final Session _session;
  const ImagePicker(this._session, {Key? key}) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  //step 1: you need temporary list
  List<Media> temporaryList = [];

  @override
  void initState() {
    print(context
        .read<Studio>()
        .getSessionSelectedMedia(widget._session.mediaIds));
    setState(() {
      temporaryList = context
          .read<Studio>()
          .getSessionSelectedMedia(widget._session.mediaIds);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media =
        context.watch<AppData>().getSessionMedia(widget._session.mediaIds);
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
      appBar: AppBarWithClose(
          'Select up to $count Images', Colors.white.withOpacity(0.85)),
      body: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            mainAxisExtent: null,
            crossAxisCount: 3,
          ),
          itemCount: media.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                //check if item exist in temporaryList, add it if doesn't exist, remove it if it does
                setState(() {
                  if (temporaryList.contains(media[index]))
                    temporaryList.remove(media[index]);
                  else
                    temporaryList.add(media[index]);
                });
              },
              child: ImagePickerContainer(
                media[index],
                temporaryList.contains(media[index]),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ImagePickerBottomContainer(
        onTap: () {
          //add tempory list into the list in the provider
          context
              .read<Studio>()
              .assignSelectedSessionMedia(temporaryList, widget._session.id);
          //call this function `assignSelectedSessionMedia` and give it the temporary list
          Navigator.pop(context);
        },
        count: temporaryList.length,
      ),
    );
  }
}
