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

class AlbumTitleTextField extends StatelessWidget {
  // final void Function(Map?) onChangedCallback;
  const AlbumTitleTextField(
    // this.onChangedCallback
    );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          customPadding: const EdgeInsets.only(top: 0, bottom: 5),
          title: 'Album title',
          type: TitleTextType.secondaryTitle,
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: TextFormField(
            onChanged: (val) {
              // return onChangedCallback({
              //   'album_title': '$val',
              // });
            },
            style: TextStyle(fontSize: 12),
            keyboardType: TextInputType.text,
            maxLines: 1,
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
              hintText: 'Enter the Album title',
              hintStyle: const TextStyle(color: AppColors.greyD0D3D6),
            ),
          ),
        )
      ],
    );
  }
}