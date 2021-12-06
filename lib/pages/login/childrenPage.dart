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

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithLogo(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
              title: 'Your Children',
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SignupFormTextFieldWidget(title: 'First Name'),
                  SignupFormTextFieldWidget(title: 'Last Name'),
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
                  SignupFormTextFieldWidget(title: 'Birthday'),
                  SignupFormTextFieldWidget(
                    title: 'Description of Their Personalities',
                    maxLines: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButtonWidget(
                        margin: EdgeInsets.only(right: 30.0),
                        customWidth: 128,
                        onPress: () {},
                        type: ButtonType.generalGrey,
                        title: 'Add more',
                      ),
                    ],
                  ),
                  FilledButtonWidget(
                    margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
                    onPress: () {},
                    type: ButtonType.generalBlue,
                    title: 'Next: Family Info',
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
