//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../pages/booking/cakePage.dart';
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
import '../form/formTextField.dart';
import '../general/cachedImageWidget.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class CakeSelector extends StatelessWidget {
  const CakeSelector();

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    return bookingsProvider.selectedCakes.length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                title: 'Cake',
                customPadding: const EdgeInsets.only(bottom: 10),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CakePage(),
                    ),
                  );
                },
                child: Container(
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
                              .getCakesByIds(bookingsProvider.selectedCakes)
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Icon(
                          Icons.edit,
                          size: 32,
                          color: AppColors.black5C6671,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        : Visibility(
            visible: bookingsProvider.package?.cakeAllowed != 0,
            child: FormTextFieldWidget(
              controller: TextEditingController(),
              customMargin:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
              title: bookingsProvider.package?.cakeAllowed == 1
                  ? 'Select Cake'
                  : 'Select ${bookingsProvider.package?.cakeAllowed ?? ''} Cakes',
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
                    builder: (context) => CakePage(),
                  ),
                );
              },
            ),
          );
  }
}
