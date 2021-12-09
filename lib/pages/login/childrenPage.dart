//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/appbars/appBarWithLogo.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showOkDialog.dart';
//PAGES
import '../../widgets/form/childrenForm.dart';

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

  // late final _firstNameController;
  // late final _lastNameController;
  // late final _birthdayController;
  // late final _detailsController;

  DateTime selectedDate = DateTime.now();
  String _formattedDate = '';

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
                  final isFormValid = _formKeysList[0].currentState?.validate();
                  List<Map> childrenList = [];

                  for (var i = 0; i < _formKeysList.length; i++) {
                    childrenList.add({
                      "first_name": _firstNameControllersList[i].text,
                      "last_name": _lastNameControllersList[i].text,
                      "gender": _genderControllersList[i].text,
                      "birthdate": _birthdayControllersList[i].text.apiDob(),
                      "personality": _detailsControllersList[i].text,
                    });
                  }

                  childrenList.forEach((element) {
                    print(element);
                  });

                  Map childrenData = {"children": childrenList};

                  print(childrenData);

                  if (isFormValid == true) {
                  } else {
                    ShowOkDialog(
                      context,
                      'Please check any missing information.',
                      title: "Oops",
                    );
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FamilyPage(),
                  //   ),
                  // );
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
