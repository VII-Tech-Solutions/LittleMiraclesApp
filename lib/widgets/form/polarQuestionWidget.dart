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

class PolarQuestionWidget extends StatefulWidget {
  final Question? question;
  final void Function(Map?) onTapCallback;
  const PolarQuestionWidget(this.question, this.onTapCallback);

  @override
  _PolarQuestionWidgetState createState() => _PolarQuestionWidgetState();
}

class _PolarQuestionWidgetState extends State<PolarQuestionWidget> {
  List<int> selectedOptions = [];

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

  Widget _buildQuestionWidget(int index) {
    Widget item = Container();

    final optionId = widget.question?.options?[index].id;
    final optionValue = widget.question?.options?[index].value;

    if (optionId != null) {
      item = Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              // if (this.selectedOptions.contains(optionId) == true) {
              //   this.selectedOptions.removeWhere((i) => i == optionId);
              // } else {
                this.selectedOptions.clear();
                this.selectedOptions.add(optionId);
              // }

              var answer = '';

              for (var i = 0; i < this.selectedOptions.length; i++) {
                if (i + 1 == this.selectedOptions.length) {
                  answer += '${this.selectedOptions[i]}';
                } else {
                  answer += '${this.selectedOptions[i]}, ';
                }
              }

              if (widget.question?.id != null) {
                return widget.onTapCallback({
                  'question_id': widget.question?.id,
                  'answer': answer,
                });
              }
            });
          },
          child: AnimatedContainer(
            height: 40,
            margin: EdgeInsets.only(top: 5),
            duration: Duration(milliseconds: 150),
            decoration: this.selectedOptions.contains(optionId) == true
                ? selectedOptionsStyle
                : unselectedOptionsStyle,
            child: Row(
              children: [
                Checkbox(
                  value: this.selectedOptions.contains(optionId) == true,
                  splashRadius: 4,
                  activeColor: AppColors.blue8DC4CB,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: this.selectedOptions.contains(optionId) == true
                        ? Colors.white
                        : AppColors.greyB9BEC2,
                    width: 0.5,
                  ),
                  onChanged: (_) {
                    setState(() {
                      // if (this.selectedOptions.contains(optionId) == true) {
                      //   this.selectedOptions.removeWhere((i) => i == optionId);
                      // } else {
                        this.selectedOptions.clear;
                        this.selectedOptions.add(optionId);
                      // }
                    });
                  },
                ),
                Text(
                  optionValue ?? '',
                ),
              ],
            ),
          ),
        ),
      );
    }

    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          customPadding: const EdgeInsets.only(top: 20, bottom: 5),
          title: widget.question?.question ?? '',
          type: TitleTextType.secondaryTitle,
        ),
        Row(
          children: [
            _buildQuestionWidget(0),
            SizedBox(width: 7),
            _buildQuestionWidget(1),
          ],
        )
      ],
    );
  }
}
