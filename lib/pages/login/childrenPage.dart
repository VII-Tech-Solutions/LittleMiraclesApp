//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../pages/login/familyPage.dart';
import '../../providers/auth.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/form/childrenForm.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSIONS

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

  void _removeAChild(int index) {
    setState(() {
      // _formKeysList.removeLast();
      // _firstNameControllersList.removeLast();
      // _lastNameControllersList.removeLast();
      // _genderControllersList.removeLast();
      // _birthdayControllersList.removeLast();
      // _detailsControllersList.removeLast();
      _formKeysList.removeAt(index);
      _firstNameControllersList.removeAt(index);
      _lastNameControllersList.removeAt(index);
      _genderControllersList.removeAt(index);
      _birthdayControllersList.removeAt(index);
      _detailsControllersList.removeAt(index);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    customPadding: EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 10.0),
                    title: 'Your Children',
                    type: TitleTextType.mainHomeTitle,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 30),
                  //   child: InkWell(
                  //     onTap: () {
                  //       context
                  //           .read<Auth>()
                  //           .amendRegistrationBody({"children": []});
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => FamilyPage(),
                  //         ),
                  //       );
                  //     },
                  //     child: Text(
                  //       'Skip',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: AppColors.black45515D,
                  //         fontWeight: FontWeight.w800,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
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
                      index + 1 == _formKeysList.length &&
                          _formKeysList.length != 1,
                      _addAChild,
                      // _removeAChild,
                      () => _removeAChild(index),
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

                  try {
                    for (var i = 0; i < _formKeysList.length; i++) {
                      childrenList.add({
                        "first_name": _firstNameControllersList[i].text,
                        "last_name": _lastNameControllersList[i].text,
                        "gender":
                            _genderControllersList[i].text.toString().toInt(),
                        "birth_date": _birthdayControllersList[i].text.apiDob(),
                        "personality": _detailsControllersList[i].text,
                      });
                    }
                  } catch (e) {
                    print('Error : $e');
                  }
                  Map childrenData;
                  if (isFormValid == true) {
                    print('child form is empty');
                    childrenData = {"children": childrenList};
                  } else {
                    childrenData = {
                      "children": {
                        "first_name": '',
                        "last_name": '',
                        "gender": 0,
                        "birth_date": '',
                        "personality": '',
                      }
                    };
                  }

                  context.read<Auth>().amendRegistrationBody(childrenData);

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
      ),
    );
  }
}
