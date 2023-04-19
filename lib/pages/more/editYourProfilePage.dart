//PACKAGES

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../global/globalHelpers.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSION

class EditYourProfilePage extends StatefulWidget {
  const EditYourProfilePage({Key? key}) : super(key: key);

  @override
  State<EditYourProfilePage> createState() => _EditYourProfilePageState();
}

class _EditYourProfilePageState extends State<EditYourProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _genderValue = '1';
  String _countryCodeValue = '+973';

  late final _firstNameController;
  late final _lastNameController;
  late final _birthdayController;
  late final _phoneController;

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

    final user = context.read<Auth>().user;

    if (user != null) {
      _firstNameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _birthdayController.text =
          'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('${user.birthDate}')}';
      _formattedDate = user.birthDate ?? '';
      _phoneController.text = user.phoneNumber ?? '';

      _genderValue = user.gender.toString();
      _countryCodeValue = '+${user.countryCode ?? ''}';
    }

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
    final user = context.read<Auth>().user;
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithBack(
        title: 'Your Profile',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: user?.avatar ?? "",
                            height: 50,
                            width: 50,
                            placeholder: (context, url) => Container(
                              color: AppColors.grey737C85,
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.grey737C85,
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TitleText(
                          customPadding: const EdgeInsets.only(top: 16),
                          title: 'Account Information',
                          type: TitleTextType.mainHomeTitle,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormTextFieldWidget(
                                title: 'First Name',
                                controller: _firstNameController,
                                customMargin: const EdgeInsets.only(top: 10),
                              ),
                              FormTextFieldWidget(
                                title: 'Last Name',
                                controller: _lastNameController,
                                customMargin: const EdgeInsets.only(top: 10),
                              ),
                              Container(
                                color: AppColors.whiteFFFFFF,
                                margin: const EdgeInsets.only(top: 10),
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                    color: AppColors.black45515D,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  value: _genderValue,
                                  items: <DropdownMenuItem<String>>[
                                    DropdownMenuItem(
                                        child: Text('Male'), value: '1'),
                                    DropdownMenuItem(
                                        child: Text('Female'), value: '2'),
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
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        16.0, 11.0, 10.0, 11.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.greyD0D3D6),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.greyD0D3D6),
                                    ),
                                  ),
                                ),
                              ),
                              FormTextFieldWidget(
                                customMargin: const EdgeInsets.only(top: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteFFFFFF,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.greyD0D3D6,
                                          width: 1,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                      customMargin: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      inputType: TextInputType.phone,
                                    ),
                                  ),
                                ],
                              ),
                              TitleText(
                                title: 'You have signed in with:',
                                type: TitleTextType.secondaryTitle,
                                weight: FontWeight.w500,
                                customPadding:
                                    const EdgeInsets.only(top: 25, bottom: 10),
                              ),
                              SvgPicture.asset(
                                'assets/images/iconsSocial${user?.provider?.firstLetterToUpper()}.svg',
                                width: 34,
                                height: 34,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FilledButtonWidget(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
        onPress: () {
          final isFormValid = _formKey.currentState?.validate();

          if (isFormValid == true) {
            Map userData = {
              "first_name": _firstNameController.text,
              "last_name": _lastNameController.text,
              "gender": _genderValue.toInt(),
              "country_code": _countryCodeValue,
              "phone_number": _phoneController.text,
              "birth_date": _formattedDate,
              "firebase_id": FirebaseAuth.instance.currentUser?.uid,
              // "device_token ": context.read<Auth>().firetoken
            };

            ShowLoadingDialog(context);
            context.read<Auth>().updateProfile(userData).then((response) {
              ShowLoadingDialog(context, dismiss: true);
              if (response?.statusCode == 200) {
                ShowOkDialog(
                  context,
                  response?.message ?? 'Profile updated succefully',
                  title: 'Yaaay',
                  popWithAction: true,
                );
              } else {
                ShowOkDialog(
                  context,
                  response?.message ?? ErrorMessages.somethingWrong,
                  title: 'Oops',
                );
              }
            });
          }
        },
        type: ButtonType.generalBlue,
        title: 'Save Changes',
      ),
    );
  }
}
