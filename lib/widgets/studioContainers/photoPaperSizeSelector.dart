//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../pages/studio/photoPaperSizePage.dart';
import '../../providers/studio.dart';
import '../form/formTextField.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class PhotoPaperSizeSelector extends StatelessWidget {
  const PhotoPaperSizeSelector();

  void _goToItemsPage(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());

    print(context.read<Studio>().selectedPrintType);

    context.read<Studio>().selectedPrintType?.id != null
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoPaperSizePage(),
            ),
          )
        : snackBar(context, title: 'Please select Print Type');
  }

  @override
  Widget build(BuildContext context) {
    final selectedPhotoPaperSize =
        context.watch<Studio>().selectedPhotoPaperSize;
    return selectedPhotoPaperSize != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                title: 'Photo Paper Size',
                customPadding: const EdgeInsets.only(bottom: 10, top: 20),
                type: TitleTextType.subTitleBlack,
                weight: FontWeight.w800,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  color: AppColors.greyE8E9EB,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.crop_square_rounded,
                                size: 38,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  selectedPhotoPaperSize.title ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.black45515D,
                                  ),
                                ),
                              ),
                            ),
                          ]),
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
            visible: true,
            child: FormTextFieldWidget(
              controller: TextEditingController(),
              customMargin: const EdgeInsets.only(top: 30),
              title: 'Photo Paper Size',
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
