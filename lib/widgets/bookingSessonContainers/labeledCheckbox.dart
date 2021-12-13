//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class LabeledCheckbox extends StatefulWidget {
  final String label;

  const LabeledCheckbox(
    this.label,
  );

  @override
  State<LabeledCheckbox> createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
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
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
