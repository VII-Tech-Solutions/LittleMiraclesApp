//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../global/globalHelpers.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/form/childrenForm.dart';
//PAGES

class EditYourChildrenPage extends StatefulWidget {
  const EditYourChildrenPage();

  @override
  _EditYourChildrenPageState createState() => _EditYourChildrenPageState();
}

class _EditYourChildrenPageState extends State<EditYourChildrenPage> {
  final _scrollController = new ScrollController();

  List<GlobalKey<FormState>> _formKeysList = [];
  List<TextEditingController> _firstNameControllersList = [];
  List<TextEditingController> _lastNameControllersList = [];
  List<TextEditingController> _genderControllersList = [];
  List<TextEditingController> _birthdayControllersList = [];
  List<TextEditingController> _personalityControllersList = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    final childrenList = context.read<Auth>().getChildrenList();

    childrenList.forEach((child) {
      _formKeysList.add(GlobalKey<FormState>());

      TextEditingController firstNameController = TextEditingController();
      firstNameController.text = child.firstName ?? '';

      TextEditingController lastNameController = TextEditingController();
      lastNameController.text = child.lastName ?? '';

      TextEditingController genderControllerList = TextEditingController();
      genderControllerList.text = child.gender.toString();

      TextEditingController birthDateController = TextEditingController();
      birthDateController.text =
          'Birthday\t\t\t\t${DateFormatClass().toddMMyyyy('${child.birthDate}')}';

      TextEditingController personalityController = TextEditingController();
      personalityController.text = child.personality ?? '';

      _firstNameControllersList.add(firstNameController);
      _lastNameControllersList.add(lastNameController);
      _genderControllersList.add(genderControllerList);
      _birthdayControllersList.add(birthDateController);
      _personalityControllersList.add(personalityController);
    });

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
    _personalityControllersList.forEach((element) {
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
      _personalityControllersList.add(TextEditingController());
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _removeAChild() {
    setState(() {
      _formKeysList.removeLast();
      _firstNameControllersList.removeLast();
      _lastNameControllersList.removeLast();
      _genderControllersList.removeLast();
      _birthdayControllersList.removeLast();
      _personalityControllersList.removeLast();
    });
    _scrollController.animateTo(
      _scrollController.position.extentBefore,
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
                      _personalityControllersList[index],
                      index + 1 == _formKeysList.length,
                      index + 1 == _formKeysList.length &&
                          _formKeysList.length != 1,
                      _addAChild,
                      _removeAChild,
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
                      "gender":
                          _genderControllersList[i].text.toString().toInt(),
                      "birth_date": _birthdayControllersList[i].text.apiDob(),
                      "personality": _personalityControllersList[i].text,
                    });
                  }

                  if (isFormValid == true) {
                    List childrenData = childrenList;

                    ShowLoadingDialog(context);
                    context
                        .read<Auth>()
                        .updateChildren(childrenData)
                        .then((response) {
                      ShowLoadingDialog(context, dismiss: true);
                      if (response?.statusCode == 200) {
                        ShowOkDialog(
                          context,
                          response?.message ??
                              'Children info updated succefully',
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
                  } else {
                    ShowOkDialog(
                      context,
                      ErrorMessages.fillRequiredInfo,
                      title: "Oops",
                    );
                  }
                },
                type: ButtonType.generalBlue,
                title: 'Save Changes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
