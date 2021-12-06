//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/form/formTextField.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
//PAGES
import '../../pages/login/partnerPage.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Female';
  String codeSelectedValue = '+973';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneController = TextEditingController();
  final detailsController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FilledButtonWidget(
                margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                onPress: () {},
                type: ButtonType.generalPink,
                title: 'Google Account',
                assetName: 'assets/images/iconsSocialGoogle.svg',
              ),
            ),
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
                    controller: firstNameController,
                  ),
                  FormTextFieldWidget(
                    title: 'Last Name',
                    controller: lastNameController,
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
                      value: selectedValue,
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                            child: Text('Female'), value: 'Female'),
                        DropdownMenuItem(child: Text('Male'), value: 'Male'),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
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
                    controller: birthdayController,
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
                        color: AppColors.whiteFFFFFF,
                        margin:
                            const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
                        child: DropdownButtonFormField(
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          value: codeSelectedValue,
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                                child: Text('+973'), value: '+973'),
                            DropdownMenuItem(
                                child: Text('+965'), value: '+965'),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                            });
                          },
                          icon: Icon(
                            Icons.expand_more,
                            color: AppColors.black45515D,
                          ),
                          hint: Text('+973'),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                16.0, 11.0, 16.0, 11.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.greyD0D3D6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.greyD0D3D6),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FormTextFieldWidget(
                          controller: phoneController,
                          title: 'Phone',
                          customMargin:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 10.0),
                        ),
                      ),
                    ],
                  ),
                  FormTextFieldWidget(
                    controller: detailsController,
                    title: 'Have you ever worked with a professional photographer?' +
                        'Were you happy with that experience? Why or why not?',
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
