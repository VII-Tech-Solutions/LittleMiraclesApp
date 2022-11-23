//PACKAGES

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/form/formTextField.dart';

//EXTENSIONS

class ChildrenForm extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _genderController;
  final TextEditingController _birthdayController;
  final TextEditingController _detailsController;
  final bool _isLast;
  final bool _showRemove;
  final VoidCallback? _onAddMorePressed;
  final VoidCallback? _removeOnPressed;
  final bool showDiv;
  const ChildrenForm(
    this._formKey,
    this._firstNameController,
    this._lastNameController,
    this._genderController,
    this._birthdayController,
    this._detailsController,
    this._isLast,
    this._showRemove,
    this._onAddMorePressed,
    this._removeOnPressed, {
    this.showDiv = true,
  });

  @override
  State<ChildrenForm> createState() => _ChildrenFormState();
}

class _ChildrenFormState extends State<ChildrenForm> {
  DateTime selectedDate = DateTime.now();
  String _formattedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        builder: (context) => Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: CupertinoDatePicker(
            onDateTimeChanged: (val) {
              setState(() {
                selectedDate = val;
                widget._birthdayController.text =
                    'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('$val')}';
                _formattedDate = DateFormatClass().toyyyyMMdd('$val');
              });
            },
            mode: CupertinoDatePickerMode.date,
            maximumYear: DateTime.now().year,
          ),
        ),
        context: context,
      );
    } else {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1960, 8),
          lastDate: DateTime.now());
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        widget._birthdayController.text =
            'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('$picked')}';
        _formattedDate = DateFormatClass().toyyyyMMdd('$picked');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return Column(
      children: [
        Form(
          key: widget._formKey,
          child: Column(
            children: [
              FormTextFieldWidget(
                title: 'First Name',
                controller: widget._firstNameController,
              ),
              FormTextFieldWidget(
                title: 'Last Name',
                controller: widget._lastNameController,
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
                  value: widget._genderController.text.isEmpty
                      ? '1'
                      : widget._genderController.text,
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(child: Text('Male'), value: '1'),
                    DropdownMenuItem(child: Text('Female'), value: '2'),
                  ],
                  onChanged: (value) {
                    widget._genderController.text = value.toString();
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
                controller: widget._birthdayController,
                title:
                    'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('${DateTime.now()}')}',
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
                  _selectDate(context);
                  FocusScope.of(context).requestFocus(
                    new FocusNode(),
                  );
                },
              ),
            ],
          ),
        ),
        FormTextFieldWidget(
          controller: widget._detailsController,
          title: 'Description of Their Personalities',
          maxLines: 8,
        ),
        widget._isLast
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: widget._showRemove,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: AppColors.blue8DC4CB,
                              size: 20,
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: AppColors.blue8DC4CB,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        onPressed: widget._removeOnPressed,
                      ),
                    ),
                  ),
                  FilledButtonWidget(
                    margin: EdgeInsets.only(right: 30.0),
                    customWidth: 128,
                    onPress: widget._onAddMorePressed,
                    type: ButtonType.generalGrey,
                    title: 'Add child',
                  ),
                ],
              )
            : Visibility(
                visible: widget.showDiv == true,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  height: 1.5,
                  width: double.infinity,
                  color: AppColors.greyD0D3D6,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
      ],
    );
  }
}
