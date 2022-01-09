//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/question.dart';
//PROVIDERS
//WIDGETS
import '../texts/titleText.dart';
//PAGES

class TextQuestionWidget extends StatelessWidget {
  final Question? question;
  final void Function(Map?) onChangedCallback;
  final TextEditingController? textController;
  const TextQuestionWidget(this.question, this.onChangedCallback,
      {this.textController = null});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          customPadding: const EdgeInsets.only(top: 20, bottom: 5),
          title: question?.question ?? '',
          type: TitleTextType.secondaryTitle,
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: TextFormField(
            controller: textController,
            onChanged: (val) {
              if (question?.id != null) {
                return onChangedCallback({
                  'question_id': question?.id,
                  'answer': '$val',
                });
              }
            },
            style: TextStyle(fontSize: 12),
            keyboardType: TextInputType.text,
            maxLines: 3,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: const EdgeInsets.fromLTRB(16.0, 11.0, 16.0, 11.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyD0D3D6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyD0D3D6),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyD0D3D6),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              hintText: 'Your Message',
              hintStyle: const TextStyle(color: AppColors.greyD0D3D6),
            ),
          ),
        )
      ],
    );
  }
}
