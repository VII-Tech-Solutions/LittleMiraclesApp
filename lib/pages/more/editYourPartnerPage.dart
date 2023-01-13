//PACKAGES

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../global/globalHelpers.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSIONS

class EditYourPartnerPage extends StatefulWidget {
  const EditYourPartnerPage({Key? key}) : super(key: key);

  @override
  _EditYourPartnerPageState createState() => _EditYourPartnerPageState();
}

class _EditYourPartnerPageState extends State<EditYourPartnerPage> {
  final _formKey = GlobalKey<FormState>();
  String _genderValue = '1';
  String _countryCodeValue = '+973';

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _phoneController;

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
          initialDate: selectedDate,
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

    final partner = context.read<Auth>().getParent();

    if (partner != null) {
      _firstNameController.text = partner.firstName ?? '';
      _lastNameController.text = partner.lastName ?? '';
      _birthdayController.text =
          'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('${partner.birthDate}')}';
      _formattedDate = partner.birthDate ?? '';
      _phoneController.text = partner.phoneNumber ?? '';

      _genderValue = partner.gender.toString();
      _countryCodeValue = '${partner.countryCode ?? ''}';
    }
    print('***');
    print(partner!.firstName);
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
      appBar: AppBarWithLogo(showLogo: false),
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
                      title:
                          'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('$selectedDate')}',
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
                            maxLines: 1,
                            title: '0000 0000',
                            customMargin: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 30.0, 10.0),
                            inputType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: AppColors.blue8DC4CB,
                          ),
                          Text(
                            'Remove',
                            style: TextStyle(color: AppColors.blue8DC4CB),
                          )
                        ],
                      ),
                    ),
                    FilledButtonWidget(
                      margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                      onPress: () {
                        final isFormValid = _formKey.currentState?.validate();

                        if (isFormValid == true) {
                          Map partnerData = {
                            "first_name": _firstNameController.text,
                            "last_name": _lastNameController.text,
                            "gender": _genderValue.toInt(),
                            "country_code": _countryCodeValue,
                            "phone_number": _phoneController.text,
                            "birth_date": _formattedDate,
                          };

                          ShowLoadingDialog(context);
                          context
                              .read<Auth>()
                              .updatePartner(partnerData)
                              .then((response) {
                            ShowLoadingDialog(context, dismiss: true);
                            if (response?.statusCode == 200) {
                              ShowOkDialog(
                                context,
                                response?.message ??
                                    'Partner info updated succefully',
                                title: 'Yaaay',
                                popWithAction: true,
                              );
                            } else {
                              ShowOkDialog(
                                context,
                                response?.message ??
                                    ErrorMessages.somethingWrong,
                                title: 'Oops',
                              );
                            }
                          });
                        }
                      },
                      type: ButtonType.generalBlue,
                      title: 'Save Changes',
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
