//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
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
import '../general/customBottomNavigationBar.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage();

  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  List<Widget> _questionsList = [];
  List<Map> _answersList = [];

  @override
  void initState() {
    context.read<Auth>().questions?.forEach((question) {
      if (question.questionType == 1) {
        _questionsList.add(
          TextQuestionWidget(
            question,
            (val) {
              return _assignAnswerValue(val, question.id);
            },
          ),
        );
      } else {
        _questionsList.add(
          MultiSelectQuestionWidget(
            question,
            (val) {
              return _assignAnswerValue(val, question.id);
            },
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
        _answersList.add(map);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
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
                      adComs) {
                    Map familyData = {"family": _answersList};

                    context.read<Auth>().amendRegistrationBody(familyData);

                    ShowLoadingDialog(context);

                    context.read<Auth>().register().then((response) {
                      ShowLoadingDialog(context, dismiss: true);
                      print('resp:$response');
                      print(response?.message);
                      print(response?.statusCode);
                      if (response?.statusCode == 200) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomBottomNavigationBar(),
                          ),
                          (Route<dynamic> route) => false,
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
                title: 'Confirm',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
