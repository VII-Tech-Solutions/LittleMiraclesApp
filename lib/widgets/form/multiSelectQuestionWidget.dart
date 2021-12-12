//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/question.dart';
//PROVIDERS
//WIDGETS
import '../texts/titleText.dart';
//PAGES

class MultiSelectQuestionWidget extends StatefulWidget {
  final Question? question;
  const MultiSelectQuestionWidget(this.question);

  @override
  _MultiSelectQuestionWidgetState createState() =>
      _MultiSelectQuestionWidgetState();
}

class _MultiSelectQuestionWidgetState extends State<MultiSelectQuestionWidget> {
  bool selected = false;

  final BoxDecoration unselectedOptionStyle = const BoxDecoration().copyWith(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    border: Border.all(
      width: 1,
      color: AppColors.greyD0D3D6,
    ),
  );

  final BoxDecoration selectedOptionStyle = const BoxDecoration().copyWith(
    color: AppColors.blueF4F9FA,
    borderRadius: BorderRadius.circular(4.0),
    border: Border.all(
      width: 1,
      color: AppColors.blue8DC4CB,
    ),
  );

  List<Widget> _buildQuestionWidget() {
    List<Widget> list = [];

    list.add(TitleText(
      customPadding: const EdgeInsets.only(top: 20, bottom: 5),
      title: 'What types of images are most important to you?',
      type: TitleTextType.secondaryTitle,
    ));

    widget.question?.options?.forEach((element) {
      list.add(InkWell(
        onTap: () {
          setState(() {
            this.selected = !selected;
          });
        },
        child: AnimatedContainer(
          height: 40,
          width: double.infinity,
          duration: Duration(milliseconds: 150),
          decoration:
              selected == true ? selectedOptionStyle : unselectedOptionStyle,
        ),
      ));
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildQuestionWidget(),
    );
  }

  Widget _old() {
    bool isChecked = false;
    Color fillColor = AppColors.whiteFFFFFF;
    Color borderColor = AppColors.greyD0D3D6;
    return Container(
      // margin: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
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
            widget.question?.question ?? '',
            style: TextStyle(
              color: AppColors.black45515D,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
