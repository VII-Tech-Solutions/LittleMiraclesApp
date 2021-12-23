//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/form/formTextField.dart';
//PAGES
import '../../pages/booking/backdropPage.dart';
import '../../pages/booking/cakePage.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTextFieldWidget(
          controller: TextEditingController(),
          customMargin:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
          title: 'Select Backdrop',
          hintStyle: TextStyle(
            color: AppColors.black45515D,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.black45515D,
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BackdropPage(),
              ),
            );
          },
        ),
        FormTextFieldWidget(
          controller: TextEditingController(),
          customMargin:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          title: 'Select Cake',
          hintStyle: TextStyle(
            color: AppColors.black45515D,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.black45515D,
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CakePage(),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Additional Comments:',
            style: TextStyle(
              color: AppColors.black45515D,
              fontSize: 14,
            ),
          ),
        ),
        FormTextFieldWidget(
          title: 'Your Message',
          controller: TextEditingController(),
          maxLines: 5,
          customWidth: double.infinity,
          customMargin:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
        )
      ],
    );
  }
}
