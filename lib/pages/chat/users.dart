// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithBack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

// Project imports:
import '../../Global/colors.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import 'chat.dart';
import 'util.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  void _handlePressed(types.User otherUserid, BuildContext context) async {
    ShowLoadingDialog(context);

    final room = await FirebaseChatCore.instance.createRoom(otherUserid);

    Navigator.of(context).pop();
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ChatPage(
              room: room,
            ),
          ),
        )
        .then((value) => ShowLoadingDialog(context, dismiss: true));
  }

  Widget _buildAvatar(user) {
    // final color = getUserAvatarNameColor(user);
    // final hasImage = user.imageUrl != null;
    // final name = getUserName(user);
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
          // imageUrl: user['imageUrl'] ?? '',
          imageUrl: '',
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
    // return Container(
    //   margin: const EdgeInsets.only(right: 16),
    //   child: CircleAvatar(
    //     backgroundColor: hasImage ? Colors.transparent : color,
    //     backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
    //     radius: 20,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseChatCore.instance.usertest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Users',
      ),
      // body: ListView.builder(
      //     itemCount: FirebaseChatCore.instance.usersData.length,
      //     itemBuilder: (context, index) {
      //       return InkWell(
      //         onTap: () {
      //           _handlePressed(
      //               FirebaseChatCore.instance.usersData[index], context);
      //         },
      //         child: Container(
      //           width: double.infinity,
      //           height: MediaQuery.of(context).size.height * 0.0887,
      //           padding: const EdgeInsets.symmetric(
      //             horizontal: 16,
      //             vertical: 8,
      //           ),
      //           child: Row(
      //             children: [
      //               _buildAvatar(FirebaseChatCore.instance.usersData[index]),
      //               Text(
      //                   '${FirebaseChatCore.instance.usersData[index]['firstName'] ?? ''} ${FirebaseChatCore.instance.usersData[index]['lastName'] ?? ''}'
      //                       .trim()),
      //             ],
      //           ),
      //         ),
      //       );

      //       // return Text(
      //       //     FirebaseChatCore.instance.usersData[index]['firstName']);
      //     })
      body: StreamBuilder<List<types.User>>(
        stream: FirebaseChatCore.instance.users(),
        initialData: [],
        builder: (context, snapshot) {
          print("hasdata ${snapshot}");
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No users'),
            );
          }
          // int index = 0;
          snapshot.data!.sort((a, b) => b.id.compareTo(a.id));
          // snapshot.data!.forEach((e) {
          //   if (e.id == 'o61U7RotNGb8ICAtjz3mShxsD802') {
          //     final tempUser = snapshot.data![0];
          //     snapshot.data![0] = snapshot.data![index];
          //     snapshot.data![index] = tempUser;
          //   }
          //   index++;
          // });
          // if (user.id == 'o61U7RotNGb8ICAtjz3mShxsD802') {
          //   final tempUser = snapshot.data![0];
          //   snapshot.data![0] = snapshot.data![index];
          //   snapshot.data![index] = tempUser;
          // }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return InkWell(
                onTap: () {
                  _handlePressed(user, context);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.0887,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(user),
                      Text(getUserName(user)),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                indent: 16,
                endIndent: 16,
                thickness: 1,
              );
            },
          );
        },
      ),
    );
  }
}
