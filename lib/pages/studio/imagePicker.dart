//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/models/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithClose.dart';
import '../../widgets/containers/imagePickerContainer.dart';

//PAGES
class ImagePicker extends StatelessWidget {
  final Session _session;
  const ImagePicker(this._session, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = context.watch<AppData>().getSessionMedia(_session.mediaIds);
    return Scaffold(
      appBar: AppBarWithClose(
          'Select up to 20 Images', AppColors.pinkD9FEF2F1.withOpacity(0.85)),
      body: GridView.builder(
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
            return ImagePickerContainer(media[index].url);
          }),
    );
  }
}
