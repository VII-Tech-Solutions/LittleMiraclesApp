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
  final void Function(Map?) onTapCallback;
  const MultiSelectQuestionWidget(this.question, this.onTapCallback);

  @override
  _MultiSelectQuestionWidgetState createState() =>
      _MultiSelectQuestionWidgetState();
}

class _MultiSelectQuestionWidgetState extends State<MultiSelectQuestionWidget> {
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

  List<Widget> _buildQuestionWidget() {
    List<Widget> list = [];

    list.add(
      TitleText(
        customPadding: const EdgeInsets.only(top: 20, bottom: 5),
        title: widget.question?.question ?? '',
        type: TitleTextType.secondaryTitle,
      ),
    );

    widget.question?.options?.forEach((element) {
      list.add(InkWell(
        onTap: () {
          setState(() {
            if (element.id != null) {
              if (this.selectedOptions.contains(element.id) == true) {
                this.selectedOptions.removeWhere((i) => i == element.id);
              } else {
                this.selectedOptions.add(element.id!);
              }

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
            }
          });
        },
        child: AnimatedContainer(
          height: 40,
          width: double.infinity,
          margin: EdgeInsets.only(top: 5),
          duration: Duration(milliseconds: 150),
          decoration: this.selectedOptions.contains(element.id) == true
              ? selectedOptionsStyle
              : unselectedOptionsStyle,
          child: Row(
            children: [
              Checkbox(
                value: this.selectedOptions.contains(element.id) == true,
                splashRadius: 4,
                activeColor: AppColors.blue8DC4CB,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(
                  color: this.selectedOptions.contains(element.id) == true
                      ? Colors.white
                      : AppColors.greyB9BEC2,
                  width: 0.5,
                ),
                onChanged: (_) {
                  setState(() {
                    if (element.id != null) {
                      if (this.selectedOptions.contains(element.id) == true) {
                        this
                            .selectedOptions
                            .removeWhere((i) => i == element.id);
                      } else {
                        this.selectedOptions.add(element.id!);
                      }
                    }
                  });
                },
              ),
              Text(
                element.value ?? '',
              ),
            ],
          ),
        ),
      ));
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildQuestionWidget(),
    );
  }
}
