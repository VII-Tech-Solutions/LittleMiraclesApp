//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/form/multiSelectQuestionWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class CanvasThicknessSelector extends StatefulWidget {
  CanvasThicknessSelector({Key? key}) : super(key: key);

  @override
  State<CanvasThicknessSelector> createState() =>
      _CanvasThicknessSelectorState();
}

class _CanvasThicknessSelectorState extends State<CanvasThicknessSelector> {
  @override
  Widget build(BuildContext context) {
    int val = -1;
    bool toggle = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 5,
          ),
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
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.blackD0D3D6,
              width: 1,
            ),
          ),
          // child: MultiSelectQuestionWidget(),
        ),
      ],
    );
  }
}
