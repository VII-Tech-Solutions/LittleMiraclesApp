// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
// Project imports:
import '../../global/colors.dart';
import 'chat.dart';
import 'util.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool _error = false;
  bool _initialized = false;
  User? _user;
  bool _badge = false;
  String authorId = '';

  @override
  void initState() {
    initializeFlutterFire();
    Future.delayed(Duration(milliseconds: 100))
        .then((_) => context.read<ChatData>().readDB());
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

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 30,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.greyF2F3F3,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.black45515D,
              size: 24,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
        title: const Text(
          'Chats',
          style: TextStyle(
            color: AppColors.black45515D,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(orderByUpdatedAt: true),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];
              _badge =
                  context.watch<ChatData>().showBadge(room.updatedAt, room.id);

              return GestureDetector(
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
                  height: MediaQuery.of(context).size.height * 0.11,
                  decoration: BoxDecoration(
                    // color: AppColors.blueE8F3F5,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.name ?? '',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black45515D),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    (200 / 375),
                                alignment: Alignment.bottomLeft,
                                child: StreamBuilder<List<types.Message>>(
                                  initialData: const [],
                                  stream: FirebaseChatCore.instance
                                      .messages(snapshot.data![index]),
                                  builder: (context, snapshot) {
                                    try {
                                      authorId = snapshot.data![0]
                                          .toJson()['author']['id'];
                                      return Text(
                                        snapshot.data![0].toJson()['text'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily:
                                              GoogleFonts.manrope().fontFamily,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.grey5C6671,
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
                      Badge(
                          showBadge: _badge &&
                              authorId !=
                                  FirebaseAuth.instance.currentUser?.uid)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
