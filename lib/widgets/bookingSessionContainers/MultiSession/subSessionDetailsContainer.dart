//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/colors.dart';
//MODELS
import '../../../models/session.dart';
//PROVIDERS
//WIDGETS
import '../../general/benefitDetailsRow.dart';
//PAGES

class SubSessionDetailsContainer extends StatelessWidget {
  final Session subSession;
  const SubSessionDetailsContainer(this.subSession);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
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
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Icon(
              Icons.edit,
              size: 32,
              color: AppColors.black5C6671,
            ),
          ),
        ],
      ),
    );
  }
}
