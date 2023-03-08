//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../pages/studio/canvasSizesPage.dart';
import '../../providers/appData.dart';
import '../../providers/studio.dart';
import '../form/formTextField.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class CanvasSizeSelector extends StatelessWidget {
  const CanvasSizeSelector();

  Future<void> _goToItemsPage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());

    context.read<Studio>().selectedCanvasThickness?.id != null
        ? await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CanvasSizePage(),
            ),
          )
        : snackBar(context, title: 'Please select Canvas Thickness');
  }

  @override
  Widget build(BuildContext context) {
    final selectedCanvasSize = context.watch<Studio>().selectedCanvasSize;
    return selectedCanvasSize != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                title: 'Canvas Size',
                customPadding: const EdgeInsets.only(bottom: 10, top: 10),
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
                                  selectedCanvasSize.title ?? '',
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
            //TODO:: check based on studio type when the API returns it later.
            visible: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Canvas Size',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                FormTextFieldWidget(
                  controller: TextEditingController(),
                  customMargin: const EdgeInsets.only(top: 10),
                  title: 'Canvas Size',
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
              ],
            ),
          );
  }
}
