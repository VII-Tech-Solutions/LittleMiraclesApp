//PACKAGES

// Flutter imports:
import 'dart:convert';

import 'package:LMP0001_LittleMiraclesApp/global/globalEnvironment.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/reviewAndPayPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/components/packageBottomBar.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/reviewAndPayGift.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../models/package.dart';
import '../../../providers/appData.dart';
import '../../../providers/auth.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/bookingSessionContainers/selectionRow.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/form/formTextField.dart';

//EXTENSIONS

class SelectPackage extends StatefulWidget {
  const SelectPackage();

  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  final _formKey = GlobalKey<FormState>();

  List<int> _selectedItems = [];
  late Package selectedPackage;
  var packageList = [];
  @override
  void initState() {
    authProvider = Provider.of<Auth>(context, listen: false);

    super.initState();
  }

  var authProvider;
// fetching package list from provider and setting first pacakge selected by default ...
  @override
  void didChangeDependencies() {
    packageList = context.watch<AppData>().packages;
    print(packageList);
    setState(() {
      selectedPackage = packageList[0];
      _selectedItems.clear();
      _selectedItems.add(0);
    });
    super.didChangeDependencies();
  }

  var giftInformation;

  Future<bool?> sendGift() async {
    bool? validForm = _formKey.currentState?.validate();

    if (validForm!) {
      ShowLoadingDialog(context);

      try {
        var url = Uri.parse(apiLink + '/gifts');
        var requestData = {
          'package_id': selectedPackage.id.toString(),
          'to': toController.text,
          'from': fromController.text,
          'message':
              messageController.text.isEmpty ? "" : messageController.text
        };

        var response = await http.post(url,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ${authProvider.token}'
            },
            body: requestData);

        if (response.statusCode == 200) {
          // API call successful

          var jsonResponse = jsonDecode(response.body);
          giftInformation = requestData;
          giftInformation['gift_id'] =
              jsonResponse['data']['gift']['id'].toString();
          giftInformation['package_name'] = selectedPackage.title;
          giftInformation['package_tag'] = selectedPackage.tag;
          giftInformation['package_price'] = selectedPackage.price.toString();

          print(giftInformation);
          ShowLoadingDialog(context, dismiss: true);

          return true;
        } else {
          // API call failed
          print('Response body: ${response.body}');
        }
        ShowLoadingDialog(context, dismiss: true);
      } catch (e) {
        print(e);
        ShowLoadingDialog(context, dismiss: true);
      }
    }
  }

  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Send a Gift',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: packageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SelectionRow(
                        () {
                          setState(() {
                            selectedPackage = packageList[index];
                            _selectedItems.clear();
                            _selectedItems.add(index);
                          });
                          print("here .. ");
                        },
                        packageList[index].image,
                        null,
                        packageList[index].title,
                        _selectedItems.contains(index),
                        1,
                        id: index,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'To:',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                    ),
                  ),
                ),
                FormTextFieldWidget(
                  title: 'Enter their email address',
                  controller: toController,
                  maxLines: 1,
                  customWidth: double.infinity,
                  customMargin:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  emailCheck: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'From:',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                    ),
                  ),
                ),
                FormTextFieldWidget(
                  title: 'Enter your name',
                  controller: fromController,
                  maxLines: 1,
                  customWidth: double.infinity,
                  customMargin:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Message (optional):',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                    ),
                  ),
                ),
                FormTextFieldWidget(
                  optional: true,
                  title: 'Your Message',
                  controller: messageController,
                  maxLines: 5,
                  customWidth: double.infinity,
                  customMargin:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: PackageBottomBar(
          selectedPackage: selectedPackage,
          onTap: () async {
            // print(selectedPackage);
            var success = await sendGift();

            if (success == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewAndPayGift(
                    giftInformation: giftInformation,
                  ),
                ),
              );
            }
          }),
    );
  }
}
