//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../models/studioMetadata.dart';
import '../../providers/appData.dart';
import '../../providers/studio.dart';

//EXTENSIONS

class CanvasThicknessSelector extends StatefulWidget {
  CanvasThicknessSelector({Key? key}) : super(key: key);

  @override
  State<CanvasThicknessSelector> createState() =>
      _CanvasThicknessSelectorState();
}

class _CanvasThicknessSelectorState extends State<CanvasThicknessSelector> {
  StudioMetadata? _selectedItem;

  final BoxDecoration unselectedOptionsStyle = const BoxDecoration().copyWith(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    border: Border.all(
      width: 1,
      color: AppColors.greyD0D3D6,
    ),
  );

  final BoxDecoration selectedOptionsStyle = const BoxDecoration().copyWith(
    color: AppColors.blueF4F9FA,
    borderRadius: BorderRadius.circular(4.0),
    border: Border.all(
      width: 1,
      color: AppColors.blue8DC4CB,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            // top: 10,
            bottom: 5,
          ),
          child: Text(
            'Canvas Thickness',
            style: TextStyle(
              color: AppColors.black45515D,
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
        Column(
          children: context
              .read<AppData>()
              .getStudioMetadata(StudioMetaCategory.canvasThickness)
              .map(
                (item) => InkWell(
                  onTap: () => setState(() {
                    _selectedItem = item;
                    context.read<Studio>().assignSelectedSpec(
                        StudioMetaCategory.canvasThickness, _selectedItem);
                    StudioMetadata? _data =
                        context.read<Studio>().selectedCanvasSize;

                    if (_data != null) {
                      var list = context.read<AppData>().getStudioCanvasSize(
                          StudioMetaCategory.canvasSize, context);
                      list.forEach((element) {
                        setState(() {
                          if (_data?.id == element.id) {
                            _data = null;
                          } else {
                            _data = element;
                          }
                        });
                      });

                      context.read<Studio>().assignSelectedSpec(
                          StudioMetaCategory.canvasSize, _data);
                      print('-----data123--- ${_data!.price}');
                    }

                    // context.read<Studio>()._selectedCanvasSize;
                  }),
                  child: AnimatedContainer(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    duration: Duration(milliseconds: 150),
                    decoration: item == _selectedItem
                        ? selectedOptionsStyle
                        : unselectedOptionsStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.greyD0D3D6,
                                width: 1,
                              )),
                          child: Container(
                            decoration: BoxDecoration(
                              color: item == _selectedItem
                                  ? AppColors.blue8DC4CB
                                  : Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          item.title ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
