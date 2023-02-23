//PACKAGES

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/admin/adminBookingPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/photographer/photographerPage.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithBackAndActions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../../Global/colors.dart';
import '../../../global/const.dart';
import '../../../models/apiResponse.dart';
import '../../../providers/appData.dart';
import '../../../providers/auth.dart';
import '../../../widgets/appbars/appBarWithLogo.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
import '../../../widgets/form/formTextField.dart';
import '../../../widgets/texts/titleText.dart';
import '../../general/customBottomNavigationBar.dart';
import '../completeProfilePage.dart';

//EXTENSIONS

class AdminPhotograher extends StatefulWidget {
  const AdminPhotograher({Key? key}) : super(key: key);

  @override
  _AdminPhotograherState createState() => _AdminPhotograherState();
}

class _AdminPhotograherState extends State<AdminPhotograher> {
  final _formKey = GlobalKey<FormState>();

  late final _firstNameController;
  late final _lastNameController;

  DateTime? selectedDate;

  Future<void> _socialLogin(
      BuildContext context, Auth authProvider, AppData appDataProvider) async {
    ApiResponse? result;

    result = await authProvider.loginAsAdmin(
        _firstNameController.text, _lastNameController.text,
        context: context);

    if (result != null) {
      if (authProvider.token.isNotEmpty) {
        final token = authProvider.token;
        await appDataProvider.fetchAndSetSessions(token: token).then((_) {
          appDataProvider.fetchAndSetAppData().then((_) {
            authProvider.getToken(withNotify: false);
            ShowLoadingDialog(context, dismiss: true);
            // if (authProvider.user?.status == 1) {
            //   authProvider.getToken(withNotify: true);
            //   FirebaseMessaging.instance
            //       .subscribeToTopic('user_${context.read<Auth>().user!.id}');
            //   FirebaseMessaging.instance.subscribeToTopic(
            //       'family_${context.read<Auth>().user!.familyId}');
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => CustomBottomNavigationBar(),
            //     ),
            //     (Route<dynamic> route) => false,
            //   );
            // }
            if (authProvider.user?.role == 2) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
                (Route<dynamic> route) => false,
              );
            } else if (authProvider.user?.role == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
                (Route<dynamic> route) => false,
              );
              // Navigator.pushAndRemoveUntil<void>(
              //   context,
              //   MaterialPageRoute<void>(
              //       builder: (BuildContext context) =>
              //           const PhotographersPage()),
              //   ModalRoute.withName('/'),
              // );
            }
          });
        });
      } else {
        ShowLoadingDialog(context, dismiss: true);
        ShowOkDialog(context, ErrorMessages.somethingWrong);
      }
    } else {
      ShowLoadingDialog(context, dismiss: true);
      ShowOkDialog(context, ErrorMessages.somethingWrong);
    }
  }

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Auth>();
    final appDataProvider = context.watch<AppData>();
    return Scaffold(
      backgroundColor: AppColors.whiteFFFFFF,
      appBar: AppBarWithBackAndActions(
        title: 'Admin/Photograher',
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
                child: Text(
                    'This is for Little Miracles Admin & Photographers.\n You must be invited first to gain access.'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                      child: Text('Email Address'),
                    ),
                    FormTextFieldWidget(
                      title: 'Enter email address',
                      controller: _firstNameController,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                      child: Text('Password'),
                    ),
                    FormTextFieldWidget(
                      title: 'Enter password',
                      controller: _lastNameController,
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 1.5,
                    ),
                    FilledButtonWidget(
                      onPress: () {
                        _socialLogin(context, authProvider, appDataProvider);
                      },
                      margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                      type: ButtonType.generalBlue,
                      title: 'Continue',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
