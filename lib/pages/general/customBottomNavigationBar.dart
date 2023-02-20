//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/admin/adminBookingPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/general/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

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
  final bool showConfetti;
  const CustomBottomNavigationBar({this.globalKey, this.showConfetti = false});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  bool _called = false;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [];

  @override
  void initState() {
    _widgetOptions = <Widget>[
      HomePage(showConfetti: widget.showConfetti),
      BookingMainPage(),
      StudioMainPage(),
      MoreMainPage()
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      context.read<Auth>().setSelectedIndex(index);
    });
  }

  Future<void> _firestoreInit() async {
    final user = context.read<Auth>().user;
    final auth = context.read<Auth>();
    try {
      if (user != null && user.id != null) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '${user.id}@lms.com',
          password: '${user.id! * 5 * 200 + 100000}',
        );
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: user.firstName,
            id: FirebaseAuth.instance.currentUser?.uid ??
                '', // UID from Firebase Authentication
            imageUrl: user.avatar,
            lastName: user.lastName,
            lastSeen: DateTime.now().millisecondsSinceEpoch,
            metadata: {
              'user_id': user.id,
              'family_id': user.familyId,
            },
          ),
        );
        Map userData = {
          "first_name": user.firstName,
          "last_name": user.lastName,
          "gender": user.gender,
          "country_code": user.countryCode.toString(),
          "phone_number": user.phoneNumber,
          "birth_date": user.birthDate,
          "firebase_id": FirebaseAuth.instance.currentUser?.uid,
          // "device_token ": context.read<Auth>().firtoken
        };
        await context.read<Auth>().updateProfile(userData);
      }

      // _initFCM();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: '${user?.id}@lms.com',
            password: '${user!.id! * 5 * 200 + 100000}');
        print('The account already exists for that email.');
        await FirebaseChatCore.instance
            .getFirebaseFirestore()
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({
          'id': FirebaseAuth.instance.currentUser?.uid,
          'firstName': user.firstName,
          'imageUrl': user.avatar,
          'lastName': user.lastName,
          'lastSeen': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'metadata': {
            'user_id': user.id,
            'family_id': user.familyId,
          },
        });
        print('sbala: ${FirebaseAuth.instance.currentUser?.uid}');
        Map userData = {
          "first_name": user.firstName,
          "last_name": user.lastName,
          "gender": user.gender,
          "country_code": user.countryCode.toString(),
          "phone_number": user.phoneNumber,
          "birth_date": user.birthDate,
          "firebase_id": FirebaseAuth.instance.currentUser?.uid,
          // "device_token ": context.read<Auth>().firtoken
        };
        await context.read<Auth>().updateProfile(userData);
      }
      // _initFCM();
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    if (_called == false) {
      _firestoreInit();
      setState(() {
        _called = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = context.watch<Auth>().selectedIndex;
    final auth = context.watch<Auth>();
    print(auth.user);
    return Scaffold(
      body: auth.user != null && auth.user!.role == 2
          ? Container()
          : Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
      bottomNavigationBar: auth.user != null && auth.user!.role == 2
          ? AdminBookingPage()
          : BottomNavigationBar(
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
