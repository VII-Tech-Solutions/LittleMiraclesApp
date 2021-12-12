//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/form/multiSelectQuestionWidget.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class FamilyPage extends StatefulWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  final favoriteController = TextEditingController();
  final roomController = TextEditingController();
  final childrenController = TextEditingController();
  final commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final question = context.read<Auth>().questions?[0];
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              customPadding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              title: 'Your Family',
              type: TitleTextType.mainHomeTitle,
            ),
            MultiSelectQuestionWidget(question),
            FilledButtonWidget(
              margin: const EdgeInsets.only(top: 30.0, bottom: 25.0),
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


// TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
//               title: 'Your Family',
//               type: TitleTextType.mainHomeTitle,
//             ),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title: 'What types of images are most important to you?',
//               type: TitleTextType.secondaryTitle,
//             ),
//             CheckboxTileWidget('Individuals'),
//             CheckboxTileWidget('Siblings Together'),
//             CheckboxTileWidget('Family'),
//             CheckboxTileWidget('Interaction'),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title: 'What is your favorite thing to do as a family?',
//               type: TitleTextType.secondaryTitle,
//             ),
//             FormTextFieldWidget(
//               controller: favoriteController,
//               title: 'Your Message',
//               maxLines: 3,
//             ),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title: 'Would you say that you prefer color, b/w, or both?',
//               type: TitleTextType.secondaryTitle,
//             ),
//             CheckboxTileWidget('Color Photos'),
//             CheckboxTileWidget('Black & White Photos'),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title: 'What types of images are most important to you?',
//               type: TitleTextType.secondaryTitle,
//             ),
//             CheckboxTileWidget('Large Display Portraits'),
//             CheckboxTileWidget('Wall Galleries With a Series of Portraits'),
//             CheckboxTileWidget('Small Gift Prints (8x10 and Under)'),
//             CheckboxTileWidget('Session Album or Book'),
//             CheckboxTileWidget('Custom Cards or Announcements'),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title:
//                   'What room(s) are you interested in hanging a wall portrait or portrait display??',
//               type: TitleTextType.secondaryTitle,
//             ),
//             FormTextFieldWidget(
//               controller: roomController,
//               title: 'Your Message',
//               maxLines: 3,
//             ),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title:
//                   'What do you hope to convey to your children through these images?',
//               type: TitleTextType.secondaryTitle,
//             ),
//             FormTextFieldWidget(
//               controller: childrenController,
//               title: 'Your Message',
//               maxLines: 3,
//             ),
//             TitleText(
//               customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 5.0),
//               title: 'Additional Comments:',
//               type: TitleTextType.secondaryTitle,
//             ),
//             FormTextFieldWidget(
//               controller: childrenController,
//               title: 'Your Message',
//               maxLines: 3,
//             ),