//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/admin/adminBookingPage.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../global/colors.dart';
import '../more/moreMainPage.dart';

class AdminBottomNavigationBar extends StatefulWidget {
  final GlobalKey? globalKey;
  final bool showChat;
  const AdminBottomNavigationBar({this.globalKey, required this.showChat});

  @override
  _AdminBottomNavigationBarState createState() =>
      _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [];

  @override
  void initState() {
    _widgetOptions = <Widget>[
      AdminBookingPage(showChat: widget.showChat),
      MoreMainPage()
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    if(index == 1){
      Navigator.of(context).pop();
    }
    else setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: widget.globalKey,
        enableFeedback: false,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Bookings',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log out',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedFontSize: 12,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        unselectedItemColor: AppColors.black45515D,
        selectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
        selectedItemColor: AppColors.blue8DC4CB,
        onTap: _onItemTapped,
      ),
    );
  }
}
