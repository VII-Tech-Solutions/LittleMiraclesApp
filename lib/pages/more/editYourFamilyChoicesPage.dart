//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/texts/titleText.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
//PAGES
import './editYourPartnerPage.dart';

class EditYourFamilyChoucesPage extends StatelessWidget {
  const EditYourFamilyChoucesPage();

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
            _containerWidget('Your Children', () {}),
            _containerWidget('Your Family', () {}),
          ],
        ),
      ),
    );
  }
}
