//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class LabeledCheckbox extends StatelessWidget {
  final int? id;
  final String? label;
  final bool? isUser;
  final bool? isSelected;
  final void Function(int?)? onTapCallback;

  const LabeledCheckbox({
    @required this.id,
    @required this.label,
    @required this.isUser,
    @required this.isSelected,
    @required this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        return onTapCallback!(id);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 13),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label ?? '',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                side: BorderSide(width: 0.5, color: AppColors.greyB9BEC2),
                activeColor: AppColors.blue8DC4CB,
                value: isSelected,
                onChanged: (bool? value) {
                  return onTapCallback!(id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
