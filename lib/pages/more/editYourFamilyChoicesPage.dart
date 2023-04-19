//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/texts/titleText.dart';
import './editYourChildrenPage.dart';
import './editYourFamilyInfoPage.dart';
import './editYourPartnerPage.dart';

//EXTENSIONS

class EditYourFamilyChoicesPage extends StatelessWidget {
  const EditYourFamilyChoicesPage();

  Widget _containerWidget(String title, VoidCallback function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 16, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColors.greyD0D3D6,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleText(
              title: title,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Your Family',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          children: [
            _containerWidget('Your Partner', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditYourPartnerPage(),
                ),
              );
            }),
            _containerWidget('Your Children', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditYourChildrenPage(),
                ),
              );
            }),
            _containerWidget('Your Family', () {
              ShowLoadingDialog(context);
              context
                  .read<Auth>()
                  .fetchRegistrationQuestions()
                  .then((response) {
                ShowLoadingDialog(context, dismiss: true);
                if (response?.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditYourFamilyInfoPage(),
                    ),
                  );
                } else {
                  ShowOkDialog(
                    context,
                    response?.message ?? ErrorMessages.somethingWrong,
                    title: "Oops",
                  );
                }
              });
            }),
          ],
        ),
      ),
    );
  }
}
