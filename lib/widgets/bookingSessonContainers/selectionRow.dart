//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/general/cachedImageWidget.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/backdrop.dart';
//PROVIDERS
//WIDGETS
//PAGES

class SelectionRow extends StatefulWidget {
  final Backdrop? backdrop;
  const SelectionRow(this.backdrop);

  @override
  _SelectionRowState createState() => _SelectionRowState();
}

class _SelectionRowState extends State<SelectionRow> {
  bool isChecked = false;
  Color fillColor = AppColors.whiteFFFFFF;
  Color borderColor = AppColors.greyD0D3D6;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.greyD0D3D6),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 68,
            width: 68,
            margin: const EdgeInsets.all(16.0),
            child: CachedImageWidget(
              widget.backdrop?.image ?? '',
              ImageShape.square,
            ),
          ),
          Text(
            widget.backdrop?.title ?? '',
            style: TextStyle(
              color: AppColors.black45515D,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
