//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/models/apiResponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/multiSelectQuestionWidget.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/texts/titleText.dart';
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
                    ApiResponse? resp;
                    context
                        .read<Auth>()
                        .register()
                        .then((value) {
                          FirebaseMessaging.instance.subscribeToTopic(
                              'user_${context.read<Auth>().user!.id}');
                          FirebaseMessaging.instance.subscribeToTopic(
                              'family_${context.read<Auth>().user!.familyId}');
                          context.read<AppData>().fetchAndSetSessions();
                          return resp = value;
                        })
                        .then((value) =>
                            context.read<AppData>().fetchAndSetAppData())
                        .then((response) {
                          ShowLoadingDialog(context, dismiss: true);
                          context.read<Auth>().getToken(withNotify: true);
                          print('resp:$resp');
                          print(resp?.message);
                          print(resp?.statusCode);
                          if (resp?.statusCode == 200) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomBottomNavigationBar(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            ShowOkDialog(
                              context,
                              resp?.message ?? ErrorMessages.somethingWrong,
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
