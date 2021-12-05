//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/form/formTextField.dart';
//PAGES

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  String selectedValue = 'Female';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 101,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
              color: AppColors.black45515D,
              size: 24,
            ),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Image.asset('assets/images/logoNameColor.png'),
      ),
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
            ),
            Form(
              child: Column(
                children: [
                  SignupFormTextField(title: 'First Name'),
                  SignupFormTextField(title: 'Last Name'),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    child: DropdownButtonFormField(
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
                            const EdgeInsets.fromLTRB(16.0, 11.0, 16.0, 11.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greyD0D3D6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greyD0D3D6),
                        ),
                      ),
                    ),
                  ),
                  SignupFormTextField(title: 'Birthday'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SignupFormTextField(
                        title: '+973',
                        customWidth: 90,
                        customMargin:
                            const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
                      ),
                      SignupFormTextField(
                        title: 'Phone',
                        customWidth: 215,
                        customMargin:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 30.0, 10.0),
                      ),
                    ],
                  ),
                  SignupFormTextField(
                    title: 'Have you ever worked with a professional photographer?' +
                        'Were you happy with that experience? Why or why not?',
                    maxLines: 8,
                  ),
                  FilledButtonWidget(
                    margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 25.0),
                    onPress: () {},
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
