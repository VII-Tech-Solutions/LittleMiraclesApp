//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/childrenForm.dart';
//PAGES
import '../../pages/login/familyPage.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  final _scrollController = new ScrollController();

  List<GlobalKey<FormState>> _formKeysList = [];
  List<TextEditingController> _firstNameControllersList = [];
  List<TextEditingController> _lastNameControllersList = [];
  List<TextEditingController> _genderControllersList = [];
  List<TextEditingController> _birthdayControllersList = [];
  List<TextEditingController> _detailsControllersList = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _formKeysList.add(GlobalKey<FormState>());
    _firstNameControllersList.add(TextEditingController());
    _lastNameControllersList.add(TextEditingController());
    _genderControllersList.add(TextEditingController());
    _birthdayControllersList.add(TextEditingController());
    _detailsControllersList.add(TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _firstNameControllersList.forEach((element) {
      element.dispose();
    });
    _lastNameControllersList.forEach((element) {
      element.dispose();
    });
    _genderControllersList.forEach((element) {
      element.dispose();
    });
    _birthdayControllersList.forEach((element) {
      element.dispose();
    });
    _detailsControllersList.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  void _addAChild() {
    setState(() {
      _formKeysList.add(GlobalKey<FormState>());
      _firstNameControllersList.add(TextEditingController());
      _lastNameControllersList.add(TextEditingController());
      _genderControllersList.add(TextEditingController());
      _birthdayControllersList.add(TextEditingController());
      _detailsControllersList.add(TextEditingController());
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithLogo(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
                title: 'Your Children',
                type: TitleTextType.mainHomeTitle,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _formKeysList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChildrenForm(
                      _formKeysList[index],
                      _firstNameControllersList[index],
                      _lastNameControllersList[index],
                      _genderControllersList[index],
                      _birthdayControllersList[index],
                      _detailsControllersList[index],
                      index + 1 == _formKeysList.length,
                      _addAChild,
                    );
                  }),
              FilledButtonWidget(
                margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
                onPress: () {
                  var isFormValid = true;

                  _formKeysList.forEach((element) {
                    final isValid = element.currentState?.validate();
                    if (isValid == false) {
                      isFormValid = false;
                    }
                  });

                  List<Map> childrenList = [];

                  for (var i = 0; i < _formKeysList.length; i++) {
                    childrenList.add({
                      "first_name": _firstNameControllersList[i].text,
                      "last_name": _lastNameControllersList[i].text,
                      "gender": _genderControllersList[i].text.toInt(),
                      "birthdate": _birthdayControllersList[i].text.apiDob(),
                      "personality": _detailsControllersList[i].text,
                    });
                  }

                  if (isFormValid == true) {
                    Map childrenData = {"children": childrenList};

                    context.read<Auth>().amendRegistrationBody(childrenData);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FamilyPage(),
                      ),
                    );
                  } else {
                    ShowOkDialog(
                      context,
                      ErrorMessages.fillRequiredInfo,
                      title: "Oops",
                    );
                  }
                },
                type: ButtonType.generalBlue,
                title: 'Next: Family Info',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
