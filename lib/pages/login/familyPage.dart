//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/form/checkboxTileWidget.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class FamilyPage extends StatefulWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
              title: 'Your Family',
              type: TitleTextType.mainHomeTitle,
            ),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title: 'What types of images are most important to you?',
              type: TitleTextType.questionTitle,
            ),
            CheckboxTileWidget('Individuals'),
            CheckboxTileWidget('Siblings Together'),
            CheckboxTileWidget('Family'),
            CheckboxTileWidget('Interaction'),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title: 'What is your favorite thing to do as a family?',
              type: TitleTextType.questionTitle,
            ),
            MultilineTextFieldWidget(
              title: 'Your Message',
              maxLines: 3,
            ),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title: 'Would you say that you prefer color, b/w, or both?',
              type: TitleTextType.questionTitle,
            ),
            CheckboxTileWidget('Color Photos'),
            CheckboxTileWidget('Black & White Photos'),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title: 'What types of images are most important to you?',
              type: TitleTextType.questionTitle,
            ),
            CheckboxTileWidget('Large Display Portraits'),
            CheckboxTileWidget('Wall Galleries With a Series of Portraits'),
            CheckboxTileWidget('Small Gift Prints (8x10 and Under)'),
            CheckboxTileWidget('Session Album or Book'),
            CheckboxTileWidget('Custom Cards or Announcements'),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title:
                  'What room(s) are you interested in hanging a wall portrait or portrait display??',
              type: TitleTextType.questionTitle,
            ),
            MultilineTextFieldWidget(
              title: 'Your Message',
              maxLines: 3,
            ),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title:
                  'What do you hope to convey to your children through these images?',
              type: TitleTextType.questionTitle,
            ),
            MultilineTextFieldWidget(
              title: 'Your Message',
              maxLines: 3,
            ),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
              title: 'Additional Comments:',
              type: TitleTextType.questionTitle,
            ),
            MultilineTextFieldWidget(
              title: 'Your Message',
              maxLines: 3,
            ),
            FilledButtonWidget(
              margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FamilyPage(),
                  ),
                );
              },
              type: ButtonType.generalBlue,
              title: 'Confirm',
            ),
          ],
        ),
      ),
    );
  }
}
