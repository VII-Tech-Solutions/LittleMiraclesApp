//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/auth.dart';
import '../booking/bookingMainPage.dart';
import '../home/homePage.dart';
import '../more/moreMainPage.dart';
import '../studio/studioMainPage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final GlobalKey? globalKey;
  const CustomBottomNavigationBar({this.globalKey});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookingMainPage(),
    StudioMainPage(),
    MoreMainPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      context.read<Auth>().setSelectedIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = context.watch<Auth>().selectedIndex;
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
            icon: Icon(Icons.home),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Studio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
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
