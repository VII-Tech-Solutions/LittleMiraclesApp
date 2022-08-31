//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../pages/booking/imageExamplePage.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/imageGrid.dart';

class PackageImageSectionContainer extends StatelessWidget {
  const PackageImageSectionContainer();

  @override
  Widget build(BuildContext context) {
    print('rebuilding image section');
    final media = context.watch<Bookings>().packageMedia;
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
                  'Image Examples',
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
                title: 'See all examples',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
