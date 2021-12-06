//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class CheckboxTileWidget extends StatefulWidget {
  final String text;
  const CheckboxTileWidget(this.text);

  @override
  _CheckboxTileWidgetState createState() => _CheckboxTileWidgetState();
}

class _CheckboxTileWidgetState extends State<CheckboxTileWidget> {
  bool isChecked = false;
  Color fillColor = AppColors.whiteFFFFFF;
  Color borderColor = AppColors.greyD0D3D6;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4),
        color: fillColor,
      ),
      child: Row(
        children: <Widget>[
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            side: BorderSide(width: 0.5, color: AppColors.greyB9BEC2),
            activeColor: AppColors.blue8DC4CB,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                if (isChecked) {
                  fillColor = AppColors.blueF4F9FA;
                  borderColor = AppColors.blue8DC4CB;
                } else if (!isChecked) {
                  fillColor = AppColors.whiteFFFFFF;
                  borderColor = AppColors.greyD0D3D6;
                }
              });
            },
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: AppColors.black45515D,
            ),
          ),
        ],
      ),
    );
  }
}


// Padding(
//   padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
//   child: CheckboxListTile(
//     tileColor: AppColors.whiteFFFFFF,
//     selectedTileColor: AppColors.blueF4F9FA,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(4.0),
//       side: BorderSide(width: 0.5, color: AppColors.greyB9BEC2),
//     ),
//     contentPadding: const EdgeInsets.all(0),
//     title: Text("title text"),
//     value: true,
//     onChanged: (bool? newValue) {
//       //onChanged(newValue);
//     },
//     controlAffinity:
//         ListTileControlAffinity.leading, //  <-- leading Checkbox
//   ),
// ),