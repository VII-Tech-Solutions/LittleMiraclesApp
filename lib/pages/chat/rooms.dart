// Flutter imports:
import 'dart:convert';

import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/chat/users.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/chatProvider.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithBack.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithBackAndActions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
// Project imports:
import '../../global/colors.dart';
import 'chat.dart';
import 'util.dart';

class RoomsPage extends StatefulWidget {
  final bool canCreateRooms;
  const RoomsPage({this.canCreateRooms = true, Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool _error = false;
  bool _initialized = false;
  User? _user;
  bool _badge = false;
  String _authorId = '';
  TextEditingController _searchCon = new TextEditingController();
  String _query = '';
  bool loading = false;
  var messageStreamData;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    initializeFlutterFire();
    Future.delayed(Duration(milliseconds: 100))
        .then((_) => context.read<ChatData>().readDB());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var response = await context.read<ChatData>().getSupportUserIds();
      final extractedData =
          jsonDecode(response.body)['data']['firebase_ids'] as List;
      for (var id in extractedData) {
        if (id == null) continue;
        await FirebaseChatCore.instance.createRoom(types.User(id: id));
      }
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      // await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage =
        room.imageUrl != null && !room.imageUrl!.contains('bitmoji');
    final name = room.name ?? '';

    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 16),
      duration: Duration(milliseconds: 300),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        // your own shape
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.greyD0D3D6),
        shape: BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: room.imageUrl ?? '',
          errorWidget: (context, url, _) {
            return Image.asset(
              'assets/images/chatPlaceHolder.png',
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            );
          },
        ),
      ),
    );

    // return Container(
    //   margin: const EdgeInsets.only(right: 16),
    //   child: CircleAvatar(
    //     backgroundColor: hasImage ? Colors.transparent : color,
    //     backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
    //     radius: 30,
    //     child: !hasImage
    //         ? Text(
    //             name.isEmpty ? '' : name[0].toUpperCase(),
    //             style: const TextStyle(color: Colors.white),
    //           )
    //         : null,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    bool match = false;
    if (_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBarWithBackAndActions(
        title: "Chat",
        weight: FontWeight.bold,
        actions: [
          if (widget.canCreateRooms == true)
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Container(
                height: 40,
                width: 40,
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const UsersPage(),
                      ),
                    );
                  },
                  color: AppColors.greyF2F3F3,
                  child: Icon(
                    Icons.add,
                    color: AppColors.black45515D,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(8.0),
                  shape: CircleBorder(),
                ),
              ),
            ),
        ],
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(orderByUpdatedAt: true),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return loading == true
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const Text('No rooms'),
                  );
          }
          // snapshot.data!.forEach((element) {
          //   if (!context
          //       .read<ChatData>()
          //       .getLastSeen
          //       .containsKey('${element.id}'))
          //     context.read<ChatData>().updateStatus(element.id, 0);
          // });
          context.read<ChatData>().addToDB();
          return Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.greyF2F3F3,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  controller: _searchCon,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontSize: 12,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                    hintText: 'Search Chat Messages',
                    hintStyle: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 12,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                      child: SvgPicture.asset(
                        'assets/images/searchAlt.svg',
                        height: 19,
                        width: 19,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                    });
                    // _searchCon.text = value;
                  },
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final room = snapshot.data![index];
                    // bool matchFound = false;
                    // FirebaseChatCore.instance
                    //     .messages(snapshot.data![index])
                    //     .forEach((element) {
                    //   element.forEach((e) {
                    //     final String? str = e.toJson()['text'];
                    //     matchFound = str?.contains(_query) ?? false;
                    //   });
                    // });
                    _badge = (snapshot
                                .data![index].metadata?['currentlyActive'] !=
                            null &&
                        !snapshot.data![index].metadata?['currentlyActive']
                            .contains(
                                FirebaseChatCore.instance.firebaseUser?.uid));
                    match =
                        room.name!.toLowerCase().contains(_query.toLowerCase());
                    return Visibility(
                      visible: _query.isEmpty || match,
                      child: InkWell(
                        onTap: () {
                          // showBadge = false;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: room,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.0887,
                          // margin: const EdgeInsets.only(
                          //   top: 5,
                          // ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  _buildAvatar(room),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        room.name ?? '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: GoogleFonts.manrope()
                                                .fontFamily,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black45515D),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (200 / 375),
                                        alignment: Alignment.bottomLeft,
                                        child:
                                            StreamBuilder<List<types.Message>>(
                                          initialData: const [],
                                          stream: FirebaseChatCore.instance
                                              .messages(snapshot.data![index]),
                                          builder: (context, snapshot) {
                                            if (snapshot.data?.isNotEmpty ??
                                                false) {
                                              messageStreamData =
                                                  snapshot.data![0];
                                            }

                                            try {
                                              _authorId = snapshot.data![0]
                                                  .toJson()['author']['id'];
                                              return Text(
                                                snapshot.data![0]
                                                    .toJson()['text'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      GoogleFonts.manrope()
                                                          .fontFamily,
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColors.black45515D,
                                                ),
                                              );
                                            } catch (e) {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Badge(
                                    padding: const EdgeInsets.only(
                                        top: 14, right: 14),
                                    showBadge: _badge &&
                                        _authorId !=
                                            FirebaseAuth
                                                .instance.currentUser?.uid &&
                                        (messageStreamData?.createdAt ?? 0) >
                                            (snapshot.data![index].metadata?[
                                                    FirebaseChatCore.instance
                                                        .firebaseUser?.uid] ??
                                                0),
                                    badgeColor: AppColors.redED0006,
                                    stackFit: StackFit.passthrough,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Visibility(
                      visible: _query.isEmpty || match,
                      child: Divider(
                        indent: 16,
                        endIndent: 16,
                        thickness: 1,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
