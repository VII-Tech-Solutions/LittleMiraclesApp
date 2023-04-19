//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../general/benefitDetailsRow.dart';

//EXTENSIONS

class PackageDetailsSectionContainer extends StatelessWidget {
  const PackageDetailsSectionContainer();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    final package = context.watch<Bookings>().package;
    final benefitList = context.watch<Bookings>().benefits;

    widgetList.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          'Package Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.black45515D,
          ),
        ),
      ),
    );

    widgetList.add(
      Visibility(
        visible: package?.content?.isNotEmpty ?? false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 11.5),
          child: Text(
            package?.content ?? '',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.black45515D,
            ),
          ),
        ),
      ),
    );

    benefitList.forEach((item) {
      final icon = '0x${item.icon}'.toInt();
      widgetList.add(
        BenefitDetailsRow(
          item.title ?? '',
          IconData(icon, fontFamily: 'MaterialIcons'),
          false,
          description: item.description,
        ),
      );
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }
}
