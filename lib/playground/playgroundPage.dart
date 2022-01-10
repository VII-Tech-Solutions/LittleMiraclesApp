//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/pages/login/childrenPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/login/familyPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../extensions/stringExtension.dart';
//GLOBAL
import '../global/colors.dart';
//MODELS
import '../models/package.dart';
import '../../../models/question.dart';
//PROVIDERS
import '../providers/auth.dart';
import '../providers/appData.dart';
import '../providers/bookings.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/texts/titleText.dart';
import '../../../widgets/form/textQuestionWidget.dart';
//PAGES

class PlayrgoundPage extends StatefulWidget {
  const PlayrgoundPage({Key? key}) : super(key: key);

  @override
  _PlayrgoundPageState createState() => _PlayrgoundPageState();
}

class _PlayrgoundPageState extends State<PlayrgoundPage> {
  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.read<Bookings>();
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          title: 'Playground',
          type: TitleTextType.mainHomeTitle,
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    'Select your 4 sessions date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black45515D,
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  height: 60,
                  color: Colors.red,
                );
              },
              childCount: 7,
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: false,
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextQuestionWidget(
                    Question(
                      id: 1,
                      question: 'Additional Comments:',
                      updatedAt: null,
                      deletedAt: null,
                      options: null,
                      order: null,
                      questionType: null,
                    ),
                    (val) {
                      if (val != null) {
                        if (val['answer'] != '') {
                          bookingsProvider
                              .amendBookingBody({'comments': val['answer']});
                        } else {
                          bookingsProvider.amendBookingBody({'comments': ''});
                        }
                      }
                    },
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
