//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../models/package.dart';
import '../../../models/session.dart';
import '../../../pages/booking/multiSessionPackage/subSessionBookingPage.dart';
import '../../general/benefitDetailsRow.dart';
import '../../texts/titleText.dart';

//EXTENSIONS

class SubSessionDetailsContainer extends StatelessWidget {
  final SubPackage? subPackage;
  final Session subSession;
  final bool canEdit;
  const SubSessionDetailsContainer(
      this.subPackage, this.subSession, this.canEdit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: canEdit
          ? EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          : EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            title: subSession.title ?? '',
            type: TitleTextType.subTitleBlack,
            weight: FontWeight.w800,
            customPadding: const EdgeInsets.only(bottom: 10),
          ),
          InkWell(
            onTap: canEdit == false
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubSessionBookingPage(subPackage),
                      ),
                    );
                  },
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 9.5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 9.5),
                      Visibility(
                        visible: subSession.formattedDate != null,
                        child: BenefitDetailsRow(
                          subSession.formattedDate ?? '',
                          Icons.today_outlined,
                          false,
                        ),
                      ),
                      Visibility(
                        visible: subSession.time != null,
                        child: BenefitDetailsRow(
                          subSession.time ?? '',
                          Icons.access_time,
                          false,
                        ),
                      ),
                      Visibility(
                        visible: subSession.formattedPeople != null,
                        child: BenefitDetailsRow(
                          subSession.formattedPeople ?? '',
                          Icons.perm_identity_rounded,
                          false,
                        ),
                      ),
                      Visibility(
                        visible: subSession.formattedBackdrop != null,
                        child: BenefitDetailsRow(
                          subSession.formattedBackdrop ?? '',
                          Icons.wallpaper,
                          false,
                        ),
                      ),
                      Visibility(
                        visible: subSession.formattedCake != null,
                        child: BenefitDetailsRow(
                          subSession.formattedCake ?? '',
                          Icons.cake_outlined,
                          false,
                        ),
                      ),
                      Visibility(
                        visible: subSession.photographerName != null,
                        child: BenefitDetailsRow(
                          subSession.photographerName ?? '',
                          Icons.photo_camera_outlined,
                          false,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: canEdit,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Icon(
                        Icons.edit,
                        size: 32,
                        color: AppColors.black5C6671,
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
