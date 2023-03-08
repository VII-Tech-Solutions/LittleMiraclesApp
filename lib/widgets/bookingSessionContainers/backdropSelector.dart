//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../pages/booking/backdropPage.dart';
import '../../pages/booking/backdropType.dart';
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
import '../form/formTextField.dart';
import '../general/cachedImageWidget.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class BackdropSelector extends StatefulWidget {
  const BackdropSelector();

  @override
  State<BackdropSelector> createState() => _BackdropSelectorState();
}

class _BackdropSelectorState extends State<BackdropSelector> {
  @override
  void initState() {
    super.initState();
    var _backdropsItems = context.read<AppData>().getBackdropsByCategoryId(6);
    context.read<Bookings>().package!.type == PackageType.miniSession &&
            _backdropsItems.length == 1
        ? context
            .read<Bookings>()
            .assignSelectedBackdrops([_backdropsItems.first.id!], "")
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    return bookingsProvider.selectedBackdrops.length > 0 ||
            bookingsProvider.customBackdrop != ''
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  title: 'Backdrop',
                  customPadding: const EdgeInsets.only(bottom: 10),
                ),
                InkWell(
                  onTap: () {
                    final appData = context.read<AppData>();

                    if (bookingsProvider.package!.type ==
                        PackageType.miniSession) {
                      if (appData.getBackdropsByCategoryId(6).length > 1) {
                        for (int i = 0;
                            i < appData.backdropCategories.length;
                            i++)
                          appData.backdropCategories[i].id == 6
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BackdropType(
                                      subPackage: null,
                                      index: i,
                                    ),
                                  ),
                                )
                              : null;
                      } else
                        null;
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BackdropPage(),
                        ),
                      );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 11),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.greyD0D3D6,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (bookingsProvider.selectedBackdrops.length > 0)
                          Expanded(
                            child: Column(
                              children: context
                                  .watch<AppData>()
                                  .getBackdropsByIds(
                                      bookingsProvider.selectedBackdrops)
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(children: [
                                        SizedBox(
                                          height: 48,
                                          width: 48,
                                          child: CachedImageWidget(
                                            e.id,
                                            e.image,
                                            ImageShape.square,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              e.title ?? '',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.black45515D),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        if (bookingsProvider.customBackdrop != '')
                          Expanded(
                              child: Text(
                                  "Custom backdrop: ${bookingsProvider.customBackdrop}")),
                        bookingsProvider.package!.type ==
                                    PackageType.miniSession &&
                                // bookingsProvider.selectedBackdrops == 6 &&
                                context
                                        .watch<AppData>()
                                        .getBackdropsByCategoryId(6)
                                        .length >
                                    1
                            ? Padding(
                                padding: const EdgeInsets.only(top: 13.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 32,
                                  color: AppColors.black5C6671,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ))
        : Visibility(
            visible: bookingsProvider.package?.backdropAllowed != 0,
            child: FormTextFieldWidget(
              controller: TextEditingController(),
              customMargin:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
              title: bookingsProvider.package?.backdropAllowed == 1
                  ? 'Select Backdrop'
                  : 'Select ${bookingsProvider.package?.backdropAllowed ?? ''} Backdrops',
              hintStyle: TextStyle(
                color: AppColors.black45515D,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.black45515D,
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                final appData = context.read<AppData>();
                print('------${bookingsProvider.selectedBackdrops}');

                if (bookingsProvider.package!.type == PackageType.miniSession) {
                  if (appData.getBackdropsByCategoryId(6).length > 1)
                    for (int i = 0; i < appData.backdropCategories.length; i++)
                      appData.backdropCategories[i].id == 6
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BackdropType(
                                  subPackage: null,
                                  index: i,
                                ),
                              ),
                            )
                          : null;
                } else
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BackdropPage(),
                    ),
                  );
              },
            ),
          );
  }
}
