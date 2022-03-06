//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../pages/home/sessions/allSessionsPage.dart';
import './filledButtonWidget.dart';

//EXTENSIONS

class ViewAllSessionsButton extends StatelessWidget {
  const ViewAllSessionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButtonWidget(
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllSessionPage(),
          ),
        );
      },
      title: 'View All Sessions',
      type: ButtonType.generalGrey,
      margin: const EdgeInsets.fromLTRB(16, 27, 16, 0),
    );
  }
}
