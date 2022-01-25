//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/package.dart';
import '../../models/session.dart';
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../texts/titleText.dart';
import '../../widgets/bookingSessionContainers/MultiSession/subSessionDetailsContainer.dart';
//PAGES
import '../../pages/booking/multiSessionPackage/subSessionBookingPage.dart';

class SessionSelector extends StatelessWidget {
  final SubPackage subPackage;
  const SessionSelector(this.subPackage);

  @override
  Widget build(BuildContext context) {
    final session =
        context.watch<Bookings>().getSubSessionBySubPackageId(subPackage.id);

    return session != null
        ? SubSessionDetailsContainer(session)
        : InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubSessionBookingPage(subPackage),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    title: subPackage.title,
                    customPadding: null,
                    type: TitleTextType.subTitleBlack,
                    weight: FontWeight.w800,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.black45515D,
                  )
                ],
              ),
            ),
          );
  }
}
