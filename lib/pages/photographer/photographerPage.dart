import 'package:LMP0001_LittleMiraclesApp/pages/admin/adminBookingDetailPage.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/admin/calendarContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/adminSliverAppBar.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/emptySliverAppBar.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/containers/adminBookingItemContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';

class PhotographersPage extends StatefulWidget {
  final bool showChat;

  const PhotographersPage({this.showChat = false, Key? key}) : super(key: key);

  @override
  State<PhotographersPage> createState() => _PhotographersPageState();
}

class _PhotographersPageState extends State<PhotographersPage> {
  final _list = [
    {
      'id': 1,
      'image': 'image',
      'description': '2 baby, 1 adult',
      'title': 'Twinkle Portrait Studio Session',
      'date': '8th, January 2022',
      'time': '10:00 AM'
    },
    {
      'id': 2,
      'image': 'image',
      'description': '1 baby, 2 adult',
      'title': 'Tread Stone',
      'date': '10th, January 2022',
      'time': '08:00 AM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Auth>();
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            print('refresh');
          },
          edgeOffset: kToolbarHeight + 9,
          displacement: kToolbarHeight + 9,
          child: CustomScrollView(
            slivers: [
              EmptySliverAppBar(),
              AdminSliverAppBar(
                  'Hi',
                  '${authProvider.user!.name != null ? authProvider.user!.name : ''} ✨',
                  widget.showChat),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CalendarContainer()),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var itemData = _list[index];
                  itemData[''];
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: (AdminBookingItemContainer(
                      image: itemData['image'].toString(),
                      description: itemData['description'].toString(),
                      title: itemData['title'].toString(),
                      date: itemData['date'].toString(),
                      time: itemData['time'].toString(),
                      onTapCallback: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AdminBookingDetailPage(),
                          ),
                        );
                      },
                    )),
                  );
                },
                childCount: _list.length,
              ))
            ],
          )),
    );
  }
}
