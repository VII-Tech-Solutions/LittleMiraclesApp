//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
//PROVIDERS
import '../../providers/studio.dart';
import '../../providers/appData.dart';
//WIDGETS
import '../form/formTextField.dart';
import '../general/cachedImageWidget.dart';
import '../texts/titleText.dart';
//PAGES

class SpreadsSelector extends StatelessWidget {
  const SpreadsSelector();

  void _goToItemsPage(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(
        //TODO:: go to album size page
        builder: (context) => Scaffold(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studioProvider = context.watch<Studio>();
    return studioProvider.selectedSpreads.length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                title: 'Spreads (Pages Count)',
                customPadding: const EdgeInsets.only(bottom: 10),
              ),
              InkWell(
                onTap: () => _goToItemsPage(context),
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
                              .getSelectedStudioMetadataByIds(
                                studioProvider.selectedSpreads,
                                StudioMetaCategory.albumSize,
                              )
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
          )
        : Visibility(
            //TODO:: check based on studio type when the API returns it later.
            visible: true,
            child: FormTextFieldWidget(
              controller: TextEditingController(),
              customMargin: const EdgeInsets.only(top: 20),
              title: 'Spreads (Pages Count)',
              hintStyle: TextStyle(
                color: AppColors.black45515D,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.black45515D,
              ),
              onTap: () => _goToItemsPage(context),
            ),
          );
  }
}
