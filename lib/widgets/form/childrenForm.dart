//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/form/formTextField.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES

class ChildrenForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _genderController;
  final TextEditingController _birthdayController;
  final TextEditingController _detailsController;
  final bool _isLast;
  final VoidCallback? _onAddMorePressed;
  const ChildrenForm(
    this._formKey,
    this._firstNameController,
    this._lastNameController,
    this._genderController,
    this._birthdayController,
    this._detailsController,
    this._isLast,
    this._onAddMorePressed,
  );

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      // selectedDate = picked;
      _birthdayController.text =
          'Birthday\t\t\t\t${DateFormatClass().getDate('${picked}')}';
      // _formattedDate = DateFormatClass().getDate('${picked}');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormTextFieldWidget(
            title: 'First Name',
            controller: _firstNameController,
          ),
          FormTextFieldWidget(
            title: 'Last Name',
            controller: _lastNameController,
          ),
          Container(
            color: AppColors.whiteFFFFFF,
            margin: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: DropdownButtonFormField(
              style: TextStyle(
                color: AppColors.black45515D,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              value: '1',
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem(child: Text('Male'), value: '1'),
                DropdownMenuItem(child: Text('Female'), value: '2'),
              ],
              onChanged: (value) {
                // setState(() {
                _genderController.text = value.toString();
                // });
              },
              icon: Icon(
                Icons.expand_more,
                color: AppColors.black45515D,
              ),
              hint: Text('Gender'),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(16.0, 11.0, 10.0, 11.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyD0D3D6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyD0D3D6),
                ),
              ),
            ),
          ),
          FormTextFieldWidget(
            controller: _birthdayController,
            title:
                'Birthday\t\t\t\t${DateFormatClass().getDate('${DateTime.now()}')}',
            hintStyle: TextStyle(
              color: AppColors.black45515D,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: Icon(
              Icons.expand_more,
              color: AppColors.black45515D,
            ),
            onTap: () {
              _selectDate(context, selectedDate);
              FocusScope.of(context).requestFocus(
                new FocusNode(),
              );
            },
          ),
          FormTextFieldWidget(
            controller: _detailsController,
            title: 'Description of Their Personalities',
            maxLines: 8,
          ),
          _isLast
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButtonWidget(
                      margin: EdgeInsets.only(right: 30.0),
                      customWidth: 128,
                      onPress: _onAddMorePressed,
                      type: ButtonType.generalGrey,
                      title: 'Add more',
                    ),
                  ],
                )
              : Container(
                  height: 1.5,
                  width: double.infinity,
                  color: AppColors.greyD0D3D6,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
        ],
      ),
    );
  }
}
