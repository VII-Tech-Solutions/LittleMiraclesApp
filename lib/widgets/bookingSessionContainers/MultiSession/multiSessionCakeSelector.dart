//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/colors.dart';
//MODELS
import '../../../models/package.dart';
//PROVIDERS
import '../../../providers/appData.dart';
//WIDGETS
import '../../form/formTextField.dart';
import '../../general/cachedImageWidget.dart';
import '../../texts/titleText.dart';
//PAGES
import '../../../pages/booking/cakePage.dart';

class MultiSessionCakeSelector extends StatelessWidget {
  final SubPackage subPackage;
  final List<int> selectedCakes;
  const MultiSessionCakeSelector(this.subPackage, this.selectedCakes);

  @override
  Widget build(BuildContext context) {
    return selectedCakes.length > 0
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
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
                        builder: (context) => CakePage(
                          subPackage: subPackage,
                          subSessionSelectedCakes: selectedCakes,
                        ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: context
                                .watch<AppData>()
                                .getCakesByIds(selectedCakes)
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
            ),
          )
        : Visibility(
            visible: subPackage.cakeAllowed != 0,
            child: FormTextFieldWidget(
              controller: TextEditingController(),
              customMargin: const EdgeInsets.only(top: 20),
              title: subPackage.cakeAllowed == 1
                  ? 'Select Cake'
                  : 'Select ${subPackage.cakeAllowed ?? ''} Cakes',
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
                    builder: (context) => CakePage(
                      subPackage: subPackage,
                      subSessionSelectedCakes: selectedCakes,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
