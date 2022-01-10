//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/colors.dart';
//MODELS
import '../../../models/question.dart';
//PROVIDERS
import '../../../providers/bookings.dart';
//WIDGETS
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/form/textQuestionWidget.dart';
import '../../../widgets/bookingSessonContainers/sessionSelector.dart';
import '../../../widgets/packageContainers/packageBottomSectionContainer.dart';
//PAGES

class MultiSessionBookingPage extends StatefulWidget {
  const MultiSessionBookingPage({Key? key}) : super(key: key);

  @override
  _MultiSessionBookingPageState createState() =>
      _MultiSessionBookingPageState();
}

class _MultiSessionBookingPageState extends State<MultiSessionBookingPage> {
  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    final subPackagesList = bookingsProvider.subPackages;
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Reserve your session',
        weight: FontWeight.w800,
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
                    'Select your ${subPackagesList.length} sessions date',
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
                return SessionSelector(subPackagesList[index]);
              },
              childCount: subPackagesList.length,
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: false,
            child: Container(
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
      bottomNavigationBar: PackageBottomSectionContainer(
        btnLabel: 'Next',
        onTap: () {
          //TODO:: go to payment review
        },
      ),
    );
  }
}
