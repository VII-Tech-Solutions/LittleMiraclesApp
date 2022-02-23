//PACKAGES
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES
import '../../pages/login/childrenPage.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({Key? key}) : super(key: key);

  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  final _formKey = GlobalKey<FormState>();
  String _genderValue = '1';
  String _countryCodeValue = '+973';

  late final _firstNameController;
  late final _lastNameController;
  late final _birthdayController;
  late final _phoneController;

  DateTime? selectedDate;
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
                _birthdayController.text =
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
          initialDate: DateTime.now(),
          firstDate: DateTime(1960, 8),
          lastDate: DateTime.now());
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        _birthdayController.text =
            'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('$picked')}';
        _formattedDate = DateFormatClass().toyyyyMMdd('$picked');
      }
    }
  }

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _birthdayController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
                title: 'Your Partner',
                type: TitleTextType.mainHomeTitle,
              ),
              Form(
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
                        value: _genderValue,
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(child: Text('Male'), value: '1'),
                          DropdownMenuItem(child: Text('Female'), value: '2'),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _genderValue = value.toString();
                          });
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
                      title: _birthdayController.text == null
                          ? _birthdayController.text
                          : 'Birthday\t\t\t\t',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
                          decoration: BoxDecoration(
                              color: AppColors.whiteFFFFFF,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.greyD0D3D6,
                                width: 1,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CountryCodePicker(
                                padding: EdgeInsets.zero,
                                favorite: ['+973'],
                                onChanged: (val) =>
                                    _countryCodeValue = val.dialCode!,
                                showFlag: false,
                                showFlagDialog: true,
                                initialSelection: _countryCodeValue,
                                textStyle: TextStyle(
                                  color: AppColors.black45515D,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Icons.expand_more,
                                color: AppColors.black45515D,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: FormTextFieldWidget(
                            controller: _phoneController,
                            title: '0000 0000',
                            customMargin: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 30.0, 10.0),
                            inputType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    FilledButtonWidget(
                      margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                      onPress: () {
                        final isFormValid = _formKey.currentState?.validate();
                        Map partnerData;
                        if (isFormValid == true) {
                          partnerData = {
                            "partner": {
                              "first_name": _firstNameController.text,
                              "last_name": _lastNameController.text,
                              "gender": _genderValue.toInt(),
                              "country_code": _countryCodeValue,
                              "phone_number": _phoneController.text,
                              "birth_date": _formattedDate,
                            },
                          };
                        } else {
                          partnerData = {
                            "partner": {
                              "first_name": '',
                              "last_name": '',
                              "gender": '',
                              "country_code": '',
                              "phone_number": '',
                              "birth_date": '',
                            },
                          };
                        }
                        context.read<Auth>().amendRegistrationBody(partnerData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChildrenPage(),
                          ),
                        );
                      },
                      type: ButtonType.generalBlue,
                      title: 'Next: Children\'s Info',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
