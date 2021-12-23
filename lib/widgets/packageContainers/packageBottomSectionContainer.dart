//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES
import '../../pages/booking/bookingSessionPage.dart';

class PackageBottomSectionContainer extends StatelessWidget {
  final String? btnLabel;
  const PackageBottomSectionContainer({
    this.btnLabel = 'Book Now',
  });

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    return Container(
      height: 100,
      width: double.infinity,
      color: AppColors.greyF2F3F3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${package?.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          FilledButtonWidget(
            customWidth: 128,
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingSessionPage(package),
                ),
              );
            },
            type: ButtonType.generalBlue,
            title: 'Book Now',
          ),
        ],
      ),
    );
  }
}
