//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/models/photographer.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/photographerPage.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../models/package.dart';
import '../../pages/booking/multiSessionPackage/subSessionBookingPage.dart';
import '../../providers/bookings.dart';
import '../../widgets/bookingSessionContainers/MultiSession/subSessionDetailsContainer.dart';
import '../dialogs/showOkDialog.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class SessionSelector extends StatelessWidget {
  final SubPackage subPackage;
  final bool canEdit;

  const SessionSelector(this.subPackage, this.canEdit);

  @override
  Widget build(BuildContext context) {
    final session =
        context.watch<Bookings>().getSubSessionBySubPackageId(subPackage.id);
    final sessionBody1 =
        context.watch<Bookings>().getSubSessionBySubPackageId(5);
    final sessionBody2 =
        context.watch<Bookings>().getSubSessionBySubPackageId(10);
    final sessionBody3 =
        context.watch<Bookings>().getSubSessionBySubPackageId(11);

    return session != null
        ? SubSessionDetailsContainer(subPackage, session, canEdit)
        : InkWell(
            onTap: () {
              final provider = context.read<Bookings>();

              switch (subPackage.id) {
                case 10:
                  {
                    if (sessionBody1 != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => SubSessionBookingPage(subPackage),
                          builder: (context) =>
                              PhotographerPage(subPackage: subPackage),
                        ),
                      );
                    } else {
                      ShowOkDialog(context, 'Please select above session');
                    }
                  }
                  break;
                case 11:
                  {
                    if (sessionBody1 != null && sessionBody2 != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => SubSessionBookingPage(subPackage),
                          builder: (context) =>
                              PhotographerPage(subPackage: subPackage),
                        ),
                      );
                    } else {
                      ShowOkDialog(context, 'Please select above session');
                    }
                  }
                  break;
                case 12:
                  {
                    if (sessionBody1 != null &&
                        sessionBody2 != null &&
                        sessionBody3 != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => SubSessionBookingPage(subPackage),
                          builder: (context) =>
                              PhotographerPage(subPackage: subPackage),
                        ),
                      );
                    } else {
                      ShowOkDialog(context, 'Please select above session');
                    }
                  }
                  break;
                default:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => SubSessionBookingPage(subPackage),
                        builder: (context) =>
                            PhotographerPage(subPackage: subPackage),
                      ),
                    );
                  }
              }
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
