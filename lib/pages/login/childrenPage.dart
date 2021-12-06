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
import '../../pages/login/familyPage.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Female';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneController = TextEditingController();
  final detailsController = TextEditingController();

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
              title: 'Your Children',
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
                    title: 'Birthday		      02/02/1980',
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
                      FocusScope.of(context).requestFocus(
                        new FocusNode(),
                      );
                    },
                  ),
                  FormTextFieldWidget(
                    controller: detailsController,
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
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FamilyPage(),
                        ),
                      );
                    },
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
