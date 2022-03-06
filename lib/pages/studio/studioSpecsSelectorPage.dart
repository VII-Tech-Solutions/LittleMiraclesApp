//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/const.dart';
import '../../models/question.dart';
import '../../models/studioPackage.dart';
import '../../providers/auth.dart';
import '../../providers/studio.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/textQuestionWidget.dart';
import '../../widgets/studioContainers/albumSizeSelector.dart';
import '../../widgets/studioContainers/albumTitleTextField.dart';
import '../../widgets/studioContainers/canvasSizeSelector.dart';
import '../../widgets/studioContainers/canvasThicknessSelector.dart';
import '../../widgets/studioContainers/coverTypeSelector.dart';
import '../../widgets/studioContainers/paperTypeSelector.dart';
import '../../widgets/studioContainers/photoPaperSizeSelector.dart';
import '../../widgets/studioContainers/printTypeSelector.dart';
import '../../widgets/studioContainers/quantitySelector.dart';
import '../../widgets/studioContainers/spreadsSelector.dart';
import '../../widgets/studioContainers/studioBottomSectionContainer.dart';
import 'photoSelection.dart';

//EXTENSIONS

class StudioSpecsSelectorPage extends StatefulWidget {
  const StudioSpecsSelectorPage();

  @override
  State<StudioSpecsSelectorPage> createState() =>
      _StudioSpecsSelectorPageState();
}

class _StudioSpecsSelectorPageState extends State<StudioSpecsSelectorPage> {
  String appBarTitle = '';
  Map _bookingBody = {};
  late final StudioPackage? studioPackage;
  late final int? packageType;

  @override
  void initState() {
    studioPackage = context.read<Studio>().studioPackage;
    packageType = studioPackage?.type;

    switch (studioPackage?.type) {
      case StudioPackageTypes.album:
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
      // CANVAS
      Visibility(
        visible: packageType == StudioPackageTypes.canvasPrint,
        child: CanvasSizeSelector(),
      ),
      // CANVAS
      Visibility(
        visible: packageType == StudioPackageTypes.canvasPrint,
        child: CanvasThicknessSelector(),
      ),
      // PHOTO
      Visibility(
        visible: packageType == StudioPackageTypes.photoPaper,
        child: PrintTypeSelector(),
      ),
      // ALBUM
      Visibility(
        visible: packageType == StudioPackageTypes.album,
        child: AlbumTitleTextField(),
      ),
      // ALBUM
      Visibility(
        visible: packageType == StudioPackageTypes.album,
        child: AlbumSizeSelector(),
      ),
      // ALBUM
      Visibility(
        visible: packageType == StudioPackageTypes.album,
        child: SpreadsSelector(),
      ),
      // PHOTO
      Visibility(
        visible: packageType == StudioPackageTypes.photoPaper,
        child: PhotoPaperSizeSelector(),
      ),
      // ALBUM or PHOTO
      Visibility(
        visible: packageType == StudioPackageTypes.album ||
            packageType == StudioPackageTypes.photoPaper,
        child: PaperTypeSelector(
          packageType: packageType,
        ),
      ),
      // ALBUM
      Visibility(
        visible: packageType == StudioPackageTypes.album,
        child: CoverTypeSelector(),
      ),
      // CANVAS or PHOTO
      Visibility(
        visible: packageType == StudioPackageTypes.canvasPrint ||
            packageType == StudioPackageTypes.photoPaper,
        child: QuantitySelector(),
      ),
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
              final auth = context.read<Auth>().isAuth;
              if (auth == true) {
                if (_isFormValid())
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoSelection(),
                    ),
                  );
              } else {
                ShowOkDialog(context, 'You need to be logged in to proceed');
              }
            }),
      ),
    );
  }

  bool _isFormValid() {
    bool isValid = true;
    final bookingsBody = context.read<Studio>().studioBody;
    switch (packageType) {
      case StudioPackageTypes.album:
        if (!bookingsBody.containsKey('album_title') ||
            bookingsBody['album_title'] == "") {
          isValid = false;
          ShowOkDialog(context, 'Please add the album title to proceed');
        } else if (!bookingsBody.containsKey('album_size')) {
          isValid = false;
          ShowOkDialog(context, 'Please select an album size to proceed');
        } else if (!bookingsBody.containsKey('spreads')) {
          isValid = false;
          ShowOkDialog(context, 'Please select an spreads to proceed');
        } else if (!bookingsBody.containsKey('paper_type')) {
          isValid = false;
          ShowOkDialog(context, 'Please select a paper type to proceed');
        } else if (!bookingsBody.containsKey('cover_type')) {
          isValid = false;
          ShowOkDialog(context, 'Please select a cover type to proceed');
        }
        break;
      case StudioPackageTypes.canvasPrint:
        if (!bookingsBody.containsKey('canvas_size')) {
          isValid = false;
          ShowOkDialog(context, 'Please select canvas size to proceed');
        } else if (!bookingsBody.containsKey('canvas_thickness')) {
          isValid = false;
          ShowOkDialog(context, 'Please select canvas thickness to proceed');
        }
        break;
      case StudioPackageTypes.photoPaper:
        if (!bookingsBody.containsKey('print_type')) {
          isValid = false;
          ShowOkDialog(context, 'Please select a print type to proceed');
        } else if (!bookingsBody.containsKey('paper_size')) {
          isValid = false;
          ShowOkDialog(context, 'Please select a paper size to proceed');
        } else if (!bookingsBody.containsKey('paper_type')) {
          isValid = false;
          ShowOkDialog(context, 'Please select a paper type to proceed');
        }
        break;
    }

    return isValid;
  }
}
