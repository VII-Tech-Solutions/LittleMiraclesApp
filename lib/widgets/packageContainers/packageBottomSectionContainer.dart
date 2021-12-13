//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES
import '../../pages/booking/bookingSessionPage.dart';

class PackageBottomSectionContainer extends StatelessWidget {
  final Package? package;
  final String? btnLabel;
  const PackageBottomSectionContainer(
    this.package, {
    this.btnLabel = 'Book Now',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: AppColors.greyF2F3F3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 0.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${package?.title}',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'BD ${package?.price}',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FilledButtonWidget(
                            customWidth: 128,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookingSessionPage(package),
                                ),
                              );
                            },
                            type: ButtonType.generalBlue,
                            title: btnLabel,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
