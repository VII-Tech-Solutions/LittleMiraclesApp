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
import '../../widgets/appbars/appBarWithLogo.dart';
//PAGES
import '../../pages/login/childrenPage.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({Key? key}) : super(key: key);

  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Female';
  String codeSelectedValue = '+973';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
      body: SingleChildScrollView(
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
                  FormTextFieldWidget(title: 'First Name'),
                  FormTextFieldWidget(title: 'Last Name'),
                  Container(
                    color: AppColors.whiteFFFFFF,
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
                  FormTextFieldWidget(title: 'Birthday'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        color: AppColors.whiteFFFFFF,
                        margin:
                            const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
                        child: DropdownButtonFormField(
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
                          title: 'Phone',
                          customMargin:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 10.0),
                        ),
                      ),
                    ],
                  ),
                  FilledButtonWidget(
                    margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                    onPress: () {
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
    );
  }
}
