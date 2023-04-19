//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../global/const.dart';
import '../../../models/session.dart';
import '../../../providers/appData.dart';
import '../../../providers/bookings.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/buttons/iconButtonWidget.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
import '../../../widgets/form/multiSelectQuestionWidget.dart';
import '../../../widgets/form/polarQuestionWidget.dart';
import '../../../widgets/form/textQuestionWidget.dart';

//EXTENSIONS

class SessionFeedbackPage extends StatefulWidget {
  final Session? subSession;
  const SessionFeedbackPage({this.subSession});

  @override
  State<SessionFeedbackPage> createState() => _SessionFeedbackPageState();
}

class _SessionFeedbackPageState extends State<SessionFeedbackPage> {
  List<Widget> _questionsList = [];
  List<Map> _answersList = [];

  List<TextEditingController> _textControllersList = [];

  @override
  void initState() {
    context.read<Bookings>().feedbackQuestions.forEach((question) {
      if (question.questionType == 1) {
        final _controller = TextEditingController();
        _textControllersList.add(_controller);
        _questionsList.add(
          TextQuestionWidget(
            question,
            (val) {
              return _assignAnswerValue(val, question.id);
            },
            textController: _controller,
          ),
        );
      } else if (question.questionType == 2) {
        _questionsList.add(
          MultiSelectQuestionWidget(
            question,
            (val) {
              return _assignAnswerValue(val, question.id);
            },
          ),
        );
      } else {
        _questionsList.add(
          PolarQuestionWidget(
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
  void dispose() {
    _textControllersList.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              centerTitle: false,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: IconButtonWidget(
                onPress: () {
                  Navigator.maybePop(context);
                },
                icon: Icons.arrow_back,
              ),
              stretch: true,
              backgroundColor: Colors.white,
              expandedHeight: 242,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 37),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.pinkFEF2F1,
                        AppColors.pinkF8C0B8,
                      ],
                    ),
                  ),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'We would ',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.w300,
                        color: AppColors.black45515D,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'love to hear from you ♥️',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black45515D,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                stretchModes: [
                  StretchMode.zoomBackground,
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(children: _questionsList);
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return FilledButtonWidget(
                      onPress: () {
                        final sessionId = widget.subSession?.id ??
                            context.read<AppData>().session?.id;
                        if (context.read<Bookings>().feedbackQuestions.length ==
                            _answersList.length) {
                          ShowLoadingDialog(context);
                          context
                              .read<Bookings>()
                              .submitSessionFeedback(sessionId, _answersList)
                              .then((response) {
                            ShowLoadingDialog(context, dismiss: true);
                            if (response?.statusCode == 200) {
                              ShowOkDialog(
                                context,
                                response?.message ??
                                    'Thanks for your feedback.',
                                title: "Yaaay",
                                popWithAction: true,
                              );
                            } else {
                              ShowOkDialog(
                                context,
                                response?.message ??
                                    ErrorMessages.somethingWrong,
                              );
                            }
                          });
                        } else {
                          ShowOkDialog(
                            context,
                            ErrorMessages.fillRequiredInfo,
                          );
                        }
                      },
                      type: ButtonType.generalBlue,
                      title: 'Send your feedback',
                    );
                  },
                  childCount: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
