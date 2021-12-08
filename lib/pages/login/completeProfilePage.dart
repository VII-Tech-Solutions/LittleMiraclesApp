//PACKAGES
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/containers/registrationAccountTypeContainer.dart';
//PAGES
import '../../pages/login/partnerPage.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _genderValue = '1';
  String _countryCodeValue = '+973';

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _detailsController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegistrationAccountTypeContainer("profileUrl", SSOType.google),
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
              title: 'Complete your profile',
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
                        'Birthday\t\t\t\t${DateFormatClass().getDate('${selectedDate}')}',
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
                          customMargin:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 10.0),
                          inputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  FormTextFieldWidget(
                    controller: _detailsController,
                    title: 'Have you ever worked with a professional photographer?' +
                        ' Were you happy with that experience? Why or why not?',
                    maxLines: 8,
                  ),
                  FilledButtonWidget(
                    margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartnerPage(),
                        ),
                      );
                    },
                    type: ButtonType.generalBlue,
                    title: 'Next: Partner\'s Info',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
