//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../general/benefitDetailsRow.dart';
//PAGES

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
