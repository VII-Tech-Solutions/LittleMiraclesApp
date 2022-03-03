import 'dart:io';
import 'package:LMP0001_LittleMiraclesApp/models/media.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../Global/colors.dart';
import '../../widgets/buttons/iconButtonWidget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.room,
  }) : super(key: key);

  final types.Room room;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
  TextEditingController _inputController = TextEditingController();
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
        final reference =
            FirebaseStorage.instanceFor(app: Firebase.apps[1]).ref(name);
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

  void _handleMessageTap(BuildContext context, types.Message message) async {
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

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: IconButtonWidget(
        onPress: () {
          Navigator.maybePop(context);
        },
        icon: Icons.arrow_back,
      ),
      stretch: true,
      backgroundColor: Colors.white,
      expandedHeight: 242,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 37),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.yellowFFFBF0,
                AppColors.yellowFFB400,
              ],
            ),
          ),
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'We got a special ',
              style: TextStyle(
                fontSize: 36,
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.w300,
                color: AppColors.black45515D,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'gift for you 🎁',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black45515D,
                  ),
                ),
              ],
            ),
          ),
        ),
        stretchModes: [
          StretchMode.zoomBackground,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).padding.bottom,
        width: double.infinity,
        color: const Color(0xebf8f8f8),
      ),
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              Navigator.maybePop(context);
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
          'Chat',
          style: TextStyle(
            color: AppColors.black45515D,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  showUserAvatars: true,
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleImageSelection,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
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


// Container(
//                   padding: EdgeInsets.only(
//                     bottom: (MediaQuery.of(context).size.height * 0.05172414),
//                     top: 8,
//                   ),
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height * 0.11083744,
//                   color: Color(0xebf8f8f8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           height:
//                               MediaQuery.of(context).size.height * 0.04433498,
//                           width: MediaQuery.of(context).size.width * 0.096,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: AppColors.blue8DC4CB,
//                               width: 2,
//                             ),
//                           ),
//                           child: Icon(
//                             Icons.add,
//                             color: AppColors.blue8DC4CB,
//                             size: 24,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                         ),
//                         width: MediaQuery.of(context).size.width * 0.68,
//                         height: MediaQuery.of(context).size.height * 0.04926108,
//                         child: TextFormField(
//                           controller: _inputController,
//                           style: TextStyle(
//                             fontSize: 12,
//                           ),
//                           onTap: () {},
//                           keyboardType: TextInputType.text,
//                           textInputAction: TextInputAction.done,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return '';
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             // suffixIcon: suffixIcon,
//                             errorStyle: TextStyle(height: 0),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 11.0),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: AppColors.greyD0D3D6),
//                               borderRadius: BorderRadius.circular(56),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: AppColors.greyD0D3D6),
//                               borderRadius: BorderRadius.circular(56),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.red),
//                               borderRadius: BorderRadius.circular(56),
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: AppColors.greyD0D3D6),
//                               borderRadius: BorderRadius.circular(56),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.red),
//                               borderRadius: BorderRadius.circular(56),
//                             ),
//                             hintText: 'Type your message',
//                             hintStyle: TextStyle(
//                               fontFamily: GoogleFonts.manrope().fontFamily,
//                               color: AppColors.black45515D,
//                               fontSize: 12,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: (() => _handleSendPressed),
//                         child: Container(
//                           height:
//                               MediaQuery.of(context).size.height * 0.04433498,
//                           width: MediaQuery.of(context).size.width * 0.096,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.blue8DC4CB,
//                             border: Border.all(
//                               color: AppColors.blue8DC4CB,
//                               width: 2,
//                             ),
//                           ),
//                           child: Icon(
//                             Icons.arrow_forward,
//                             color: AppColors.whiteFFFFFF,
//                             size: 24,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),