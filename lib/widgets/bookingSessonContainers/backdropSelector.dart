//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/form/formTextField.dart';
//PAGES
import '../../pages/booking/backdropPage.dart';

class BackdropSelector extends StatelessWidget {
  const BackdropSelector();

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = context.watch<Bookings>();
    return FormTextFieldWidget(
      controller: TextEditingController(),
      customMargin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
      title: bookingsProvider.package?.backdropAllowed == 1
          ? 'Select Backdrop'
          : 'Select ${bookingsProvider.package?.backdropAllowed} Backdrops',
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
    );
  }
}
