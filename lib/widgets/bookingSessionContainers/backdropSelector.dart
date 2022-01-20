//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/form/formTextField.dart';
import '../general/cachedImageWidget.dart';
import '../../widgets/texts/titleText.dart';
//PAGES
import '../../pages/booking/backdropPage.dart';

class BackdropSelector extends StatelessWidget {
  const BackdropSelector();

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    return bookingsProvider.selectedBackdrops.length > 0
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.greyD0D3D6,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: context
                              .watch<AppData>()
                              .getBackdropsByIds(
                                  bookingsProvider.selectedBackdrops)
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: [
                                    SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: CachedImageWidget(
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BackdropPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: Icon(
                            Icons.edit,
                            size: 32,
                            color: AppColors.black5C6671,
                          ),
                        ),
                      )
                    ],
                  ),
                )
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
