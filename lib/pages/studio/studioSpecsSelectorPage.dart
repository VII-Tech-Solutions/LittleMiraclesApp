//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/question.dart';
//PROVIDERS
import '../../providers/studio.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
import '../../widgets/studioContainers/albumTitleTextField.dart';
import '../../widgets/studioContainers/albumSizeSelector.dart';
import '../../widgets/studioContainers/spreadsSelector.dart';
import '../../widgets/studioContainers/paperTypeSelector.dart';
import '../../widgets/studioContainers/coverTypeSelector.dart';
//PAGES

class StudioSpecsSelectorPage extends StatefulWidget {
  const StudioSpecsSelectorPage();

  @override
  State<StudioSpecsSelectorPage> createState() =>
      _StudioSpecsSelectorPageState();
}

class _StudioSpecsSelectorPageState extends State<StudioSpecsSelectorPage> {
  String appBarTitle = '';
  Map _bookingBody = {};

  @override
  void initState() {
    final studioPackage = context.read<Studio>().studioPackage;

    switch (studioPackage?.type) {
      case StudioPackageTypes.photoAlbum:
        appBarTitle = 'Album Specs';
        break;
      case StudioPackageTypes.canvasPrint:
        appBarTitle = 'Canvas Specs';
        break;
      case StudioPackageTypes.photoPaper:
        appBarTitle = 'Photo Paper Specs';
        break;
      default:
    }

    // _bookingBody.addAll({'package_id': provider.package?.id});

    // final date = DateTime.now().toyyyyMMdd();
    // final time = DateTime.now().tohhmma();

    // _bookingBody.addAll({
    //   "date": date,
    //   "time": time,
    // });

    // context.read<Bookings>().amendMultiSessionBookingBody(_bookingBody);

    super.initState();
  }

  @override
  void deactivate() {
    context.read<Studio>().resetBookingsData();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _selectorWidgets = [
      AlbumTitleTextField(),
      AlbumSizeSelector(),
      SpreadsSelector(),
      PaperTypeSelector(),
      CoverTypeSelector(),
    ];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarWithBack(
          title: appBarTitle,
          weight: FontWeight.w800,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _selectorWidgets[index];
                  },
                  childCount: _selectorWidgets.length,
                ),
              ),
              SliverFillRemaining(
                fillOverscroll: false,
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  margin: const EdgeInsets.only(top: 20),
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
                              _bookingBody.addAll({'comments': val['answer']});
                            } else {
                              _bookingBody.addAll({'comments': ''});
                            }
                            // context
                            //     .read<Bookings>()
                            //     .amendMultiSessionBookingBody(_bookingBody);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: StudioBottomSectionContainer(
            btnLabel: 'Next',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(),
                ),
              );
            }),
      ),
    );
  }
}
