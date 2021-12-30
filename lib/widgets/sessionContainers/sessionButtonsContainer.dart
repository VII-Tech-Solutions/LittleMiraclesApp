//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../buttons/filledButtonWidget.dart';
//PAGES

class SessionButtonContainer extends StatelessWidget {
  const SessionButtonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 46, 16, 25),
      child: Column(
        children: [
          FilledButtonWidget(
            onPress: () {},
            title: 'Send a message',
            type: ButtonType.generalGrey,
          ),
          SizedBox(height: 10),
          FilledButtonWidget(
            onPress: () {},
            title: 'Reschedule Session',
            type: ButtonType.generalBlue,
          ),
        ],
      ),
    );
  }
}
