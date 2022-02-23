//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
//EXTENSION
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/familyInfo.dart';
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/form/multiSelectQuestionWidget.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
//PAGES

class EditYourFamilyInfoPage extends StatefulWidget {
  const EditYourFamilyInfoPage();

  @override
  _EditYourFamilyInfoPageState createState() => _EditYourFamilyInfoPageState();
}

class _EditYourFamilyInfoPageState extends State<EditYourFamilyInfoPage> {
  List<Widget> _questionsList = [];
  List<Map> _answersList = [];

  @override
  void initState() {
    final familyInfoList = context.read<Auth>().familyInfoList;

    context.read<Auth>().questions?.forEach((question) {
      if (question.questionType == 1) {
        final FamilyInfo? info = familyInfoList
            .firstWhereOrNull((element) => element.questionId == question.id);

        _answersList.add({'question_id': question.id, 'answer': info?.answer});

        _questionsList.add(
          TextQuestionWidget(
            question,
            (val) {
              return _assignAnswerValue(val, question.id);
            },
            initialValue: info?.answer,
          ),
        );
      } else {
        final FamilyInfo? info = familyInfoList
            .firstWhereOrNull((element) => element.questionId == question.id);

        _answersList.add({'question_id': question.id, 'answer': info?.answer});

        final selections = info?.answer.toString().toIntList();

        _questionsList.add(
          MultiSelectQuestionWidget(
            question,
            (val) {
              return _assignAnswerValue(val, question.id);
            },
            initialSelections: selections,
          ),
        );
      }
    });

    super.initState();
  }

  _assignAnswerValue(Map<dynamic, dynamic>? map, int? questionId) {
    if (map != null) {
      _answersList.removeWhere((element) => element.containsValue(questionId));

      if (map['answer'] != '') {
        print(map);
        _answersList.add(map);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(showLogo: false),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                customPadding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                title: 'Your Family',
                type: TitleTextType.mainHomeTitle,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _questionsList,
              ),
              FilledButtonWidget(
                margin: const EdgeInsets.only(top: 30.0, bottom: 25.0),
                onPress: () {
                  bool adComs = false;
                  context.read<Auth>().questions?.forEach((element) {
                    if (element.question == 'Additional Comments:')
                      adComs = true;
                    else
                      adComs = false;
                  });
                  if (context.read<Auth>().questions?.length ==
                          _answersList.length ||
                      adComs == true) {
                    List familyData = _answersList;

                    print(familyData);

                    ShowLoadingDialog(context);
                    context
                        .read<Auth>()
                        .updateFamilyInfo(familyData)
                        .then((response) {
                      ShowLoadingDialog(context, dismiss: true);
                      if (response?.statusCode == 200) {
                        ShowOkDialog(
                          context,
                          response?.message ?? 'Family info updated succefully',
                          title: 'Yaaay',
                          popWithAction: true,
                        );
                      } else {
                        ShowOkDialog(
                          context,
                          response?.message ?? ErrorMessages.somethingWrong,
                          title: "Oops",
                        );
                      }
                    });
                  } else {
                    ShowOkDialog(
                      context,
                      ErrorMessages.fillRequiredInfo,
                      title: "Oops",
                    );
                  }
                },
                type: ButtonType.generalBlue,
                title: 'Save Changes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
