//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/imageGrid.dart';
//PAGES
import '../../pages/booking/imageExamplePage.dart';

class StudioImageSectionContainer extends StatelessWidget {
  const StudioImageSectionContainer();

  @override
  Widget build(BuildContext context) {
    final media = context.watch<Studio>().packageMedia;
    return Visibility(
      visible: media.isNotEmpty,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageExamplePage(media),
            ),
          );
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: Text(
                  'Image Prints', //TODO:: change this to match the studio type
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.black45515D,
                  ),
                ),
              ),
              Center(
                child: ImageGridWidget(media),
              ),
              FilledButtonWidget(
                onPress: null,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                type: ButtonType.generalGrey,
                title: 'See all prints',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
