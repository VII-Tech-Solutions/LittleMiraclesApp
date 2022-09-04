// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/providers/chatProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:provider/provider.dart';
import '../../Global/colors.dart';
import '../../global/const.dart';
import '../../global/globalEnvironment.dart';
import '../../global/globalHelpers.dart';
import '../../providers/auth.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/global/globalHelpers.dart' as global;

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.room,
  }) : super(key: key);

  final types.Room room;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isAttachmentUploading = false;
  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  bool bottomNav = true;
  void _handleMessageTap(BuildContext context, types.Message message) async {
    setState(() {
      bottomNav = false;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state: $state');
    if (state == AppLifecycleState.resumed) {
      FirebaseChatCore.instance.updateRoom(widget.room, currentlyActive: true);
    } else {
      FirebaseChatCore.instance.updateRoom(widget.room, currentlyActive: false);
    }
  }

  void _handleSendPressed(types.PartialText message) async {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
    FirebaseChatCore.instance.updateRoom(widget.room, currentlyActive: true);
    Future.delayed(Duration(milliseconds: 500)).then((_) => context
        .read<ChatData>()
        .updateStatus(widget.room.id, DateTime.now().millisecondsSinceEpoch));
    final url = Uri.parse('$apiLink/chat');
    final auth = context.read<Auth>();
    final otherUserDoc = await FirebaseFirestore.instance
        .collection('rooms')
        .doc(widget.room.id)
        .get();
    final List activeUsersInRoom =
        otherUserDoc.data()?['metadata']['currentlyActive'];
    final arrayOfIds = otherUserDoc.data()!['userIds'];
    String receiverId;
    if (arrayOfIds[0] == FirebaseAuth.instance.currentUser!.uid)
      receiverId = arrayOfIds[1];
    else
      receiverId = arrayOfIds[0];
    final otherUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .get();
    final recieverFamilyId = otherUserData.data()!['metadata']['family_id'];
    final recieverUserId = otherUserData.data()!['metadata']['user_id'];
    if (!activeUsersInRoom.contains(receiverId)) {
      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Platform': '${await AppInfo().platformInfo()}',
            'App-Version': '${await AppInfo().versionInfo()}',
            'Authorization': 'Bearer ${auth.token}',
          },
          body: {
            'title':
                'Message from ${auth.user!.firstName} ${auth.user?.lastName}',
            'message': '${message.text}',
            'topic': 'user_${recieverUserId}',
            'room_id': widget.room.id,
            'family_id': '${recieverFamilyId}'
          },
        ).timeout(Duration(seconds: Timeout.value));

        final result = json.decode(response.body);

        if (response.statusCode != 200) {
          if ((response.statusCode >= 400 && response.statusCode <= 499) ||
              response.statusCode == 503) {
            print(
                'statusCode: ${response.statusCode} message: ${result['message'].toString()}');
          } else {
            return null;
          }
        }
        print(
            'not in if statement: statusCode: ${response.statusCode} message: ${result['message'].toString()}');
      } on TimeoutException catch (e) {
        print('Exception Timeout:: $e');
      } catch (e) {
        print('catch error:: $e');
      }
    }
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    global.roomId = widget.room.id;
    Future.delayed(Duration(milliseconds: 500)).then((_) => context
        .read<ChatData>()
        .updateStatus(widget.room.id, DateTime.now().millisecondsSinceEpoch));
    FirebaseChatCore.instance.updateRoom(widget.room, currentlyActive: true);
    //     metadata: {
    //   'user_id': user.id,
    //   'family_id': user.familyId,
    // }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    global.roomId = null;
    _scaffoldKey.currentContext
        ?.read<ChatData>()
        .updateStatus(widget.room.id, DateTime.now().millisecondsSinceEpoch);
    FirebaseChatCore.instance.updateRoom(widget.room);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 500)).then((_) => _scaffoldKey
        .currentContext
        ?.read<ChatData>()
        .updateStatus(widget.room.id, DateTime.now().millisecondsSinceEpoch));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).padding.bottom,
        width: double.infinity,
        color: const Color(0xebf8f8f8),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) {
            return StreamBuilder<List<types.Message>>(
              initialData: const [],
              stream: FirebaseChatCore.instance.messages(snapshot.data!),
              builder: (context, snapshot) {
                return Chat(
                  timeFormat: DateFormat("h:mm a"),
                  showUserAvatars: true,
                  showUserNames: true,
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleImageSelection,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  onEndReachedThreshold: 0.75,
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
