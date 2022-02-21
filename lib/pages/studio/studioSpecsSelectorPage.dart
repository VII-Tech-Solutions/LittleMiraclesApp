//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/providers/auth.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/studioContainers/canvasSizeSelector.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/studioContainers/canvasThicknessSelector.dart';
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
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
import '../../widgets/studioContainers/albumTitleTextField.dart';
import '../../widgets/studioContainers/albumSizeSelector.dart';
import '../../widgets/studioContainers/spreadsSelector.dart';
import '../../widgets/studioContainers/paperTypeSelector.dart';
import '../../widgets/studioContainers/coverTypeSelector.dart';
//PAGES
import 'photoSelection.dart';

class StudioSpecsSelectorPage extends StatefulWidget {
  const StudioSpecsSelectorPage();

  @override
  State<StudioSpecsSelectorPage> createState() =>
      _StudioSpecsSelectorPageState();
}

class _StudioSpecsSelectorPageState extends State<StudioSpecsSelectorPage> {
  String appBarTitle = '';
  Map _bookingBody = {};
  late final studioPackage;

  @override
  void initState() {
    studioPackage = context.read<Studio>().studioPackage;

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
      Visibility(
        visible: studioPackage?.type == StudioPackageTypes.canvasPrint,
        child: CanvasSizeSelector(),
      ),
      Visibility(
        visible: studioPackage?.type == StudioPackageTypes.canvasPrint,
        child: CanvasThicknessSelector(),
      ),
      // Visibility(
      //   visible: studioPackage?.type == StudioPackageTypes.canvasPrint,
      //   child: CanvasQuantitySelector(),
      // ),
      Visibility(
          visible: studioPackage?.type == StudioPackageTypes.photoAlbum,
          child: AlbumTitleTextField()),
      Visibility(
          visible: studioPackage?.type == StudioPackageTypes.photoAlbum,
          child: AlbumSizeSelector()),
      Visibility(
          visible: studioPackage?.type == StudioPackageTypes.photoAlbum,
          child: SpreadsSelector()),
      Visibility(
          visible: studioPackage?.type == StudioPackageTypes.photoAlbum,
          child: PaperTypeSelector()),
      Visibility(
          visible: studioPackage?.type == StudioPackageTypes.photoAlbum,
          child: CoverTypeSelector()),
    ];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarWithBack(
          title: appBarTitle,
          weight: FontWeight.w800,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
              final bookingsBody = context.read<Studio>().studioBody;
              final auth = context.read<Auth>().isAuth;
              if (auth == true) {
                if (!bookingsBody.containsKey('album_title') ||
                    bookingsBody['album_title'] == "") {
                  ShowOkDialog(
                      context, 'Please add the album title to proceed');
                } else if (!bookingsBody.containsKey('album_size')) {
                  ShowOkDialog(
                      context, 'Please select an album size to proceed');
                } else if (!bookingsBody.containsKey('spreads')) {
                  ShowOkDialog(
                      context, 'Please select an album size to proceed');
                } else if (!bookingsBody.containsKey('paper_type')) {
                  ShowOkDialog(
                      context, 'Please select a paper type to proceed');
                } else if (!bookingsBody.containsKey('cover_type')) {
                  ShowOkDialog(
                      context, 'Please select a cover type to proceed');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoSelection(),
                    ),
                  );
                }
              } else {
                ShowOkDialog(context, 'You need to be logged in to proceed');
              }
            }),
      ),
    );
  }
}
