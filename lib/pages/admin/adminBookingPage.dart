import 'package:LMP0001_LittleMiraclesApp/extensions/dateTimeExtension.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/admin/adminBookingDetailPage.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/bookings.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/admin/calendarContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/adminSliverAppBar.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/emptySliverAppBar.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/containers/adminBookingItemContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Global/colors.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../general/splashscreen.dart';

class AdminBookingPage extends StatefulWidget {
  final bool showChat;

  const AdminBookingPage({this.showChat = false, Key? key}) : super(key: key);

  @override
  State<AdminBookingPage> createState() => _AdminBookingPageState();
}

class _AdminBookingPageState extends State<AdminBookingPage> {
  init() {
    final bookingsProvider = context.watch<Bookings>();
    bookingsProvider.fetchAdminSessionDetails(
        date: DateTime.now().toyyyyMMdd());
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      init();
    });
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      final user = context.read<Auth>().user;
      final userId = user?.id;
      final familyId = user?.familyId;
      context.read<AppData>().clearUserData().then(
            (_) => context.read<Auth>().logout().then(
              (_) {
                FirebaseAuth.instance.signOut();
                FirebaseMessaging.instance.unsubscribeFromTopic('user_$userId');
                FirebaseMessaging.instance
                    .unsubscribeFromTopic('family_$familyId');
                return Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Splashscreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Auth>();
    final bookingsProvider = context.watch<Bookings>();

    // bookingsProvider.fetchAdminSessionDetails();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 0,
        unselectedFontSize: 12,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        unselectedItemColor: AppColors.black45515D,
        selectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
        selectedItemColor: AppColors.blue8DC4CB,
        onTap: _onItemTapped,
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            print('refresh');
            print(authProvider.user!.name);
          },
          edgeOffset: kToolbarHeight + 9,
          displacement: kToolbarHeight + 9,
          child: CustomScrollView(
            slivers: [
              EmptySliverAppBar(),
              AdminSliverAppBar(
                  'Hi',
                  '${authProvider.user != null ? authProvider.user!.name : ''} ✨',
                  authProvider.user!.role == 1 ? false : true),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CalendarContainer()),
              ),
              if (bookingsProvider.sessionList != null &&
                  bookingsProvider.sessionList!.length != 0)
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: (AdminBookingItemContainer(
                        image: bookingsProvider
                            .sessionList![index].featuredImage
                            .toString(),
                        description: bookingsProvider
                            .sessionList![index].formattedPeople
                            .toString(),
                        title: bookingsProvider.sessionList![index].title
                            .toString(),
                        date: bookingsProvider.sessionList![index].date
                            .toString(),
                        time: bookingsProvider.sessionList![index].time
                            .toString(),
                        onTapCallback: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdminBookingDetailPage(
                                  sessionDetails:
                                      bookingsProvider.sessionList![index]),
                            ),
                          );
                        },
                      )),
                    );
                  },
                  childCount: bookingsProvider.sessionList!.length,
                ))
              else
                SliverToBoxAdapter(
                  child: Center(child: Text('No data')),
                )
            ],
          )),
    );
  }
}
