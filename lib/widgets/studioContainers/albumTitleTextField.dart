//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/studio.dart';
import '../texts/titleText.dart';

//EXTENSIONS

class AlbumTitleTextField extends StatelessWidget {
  const AlbumTitleTextField();

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
              context.read<Studio>().amendBookingBody({'album_title': val});
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
