import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/emoji_enlargement_behavior.dart';
import '../util.dart';
import 'file_message.dart';
import 'image_message.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';
import 'text_message.dart';

/// Base widget for all message types in the chat. Renders bubbles around
/// messages and status. Sets maximum width for a message for
/// a nice look on larger screens.
class Message extends StatelessWidget {
  /// Creates a particular message from any message type
  const Message({
    Key? key,
    this.bubbleBuilder,
    this.customMessageBuilder,
    required this.emojiEnlargementBehavior,
    this.fileMessageBuilder,
    required this.hideBackgroundOnEmojiMessages,
    this.imageMessageBuilder,
    required this.message,
    required this.messageWidth,
    this.onAvatarTap,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.onMessageTap,
    this.onPreviewDataFetched,
    required this.roundBorder,
    required this.showAvatar,
    required this.showName,
    required this.showStatus,
    required this.showUserAvatars,
    this.textMessageBuilder,
    required this.usePreviewData,
  }) : super(key: key);

  /// Customize the default bubble using this function. `child` is a content
  /// you should render inside your bubble, `message` is a current message
  /// (contains `author` inside) and `nextMessageInGroup` allows you to see
  /// if the message is a part of a group (messages are grouped when written
  /// in quick succession by the same author)
  final Widget Function(
    Widget child, {
    required types.Message message,
    required bool nextMessageInGroup,
  })? bubbleBuilder;

  /// Build a custom message inside predefined bubble
  final Widget Function(types.CustomMessage, {required int messageWidth})?
      customMessageBuilder;

  /// Controls the enlargement behavior of the emojis in the
  /// [types.TextMessage].
  /// Defaults to [EmojiEnlargementBehavior.multi].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// Build a file message inside predefined bubble
  final Widget Function(types.FileMessage, {required int messageWidth})?
      fileMessageBuilder;

  /// Hide background for messages containing only emojis.
  final bool hideBackgroundOnEmojiMessages;

  /// Build an image message inside predefined bubble
  final Widget Function(types.ImageMessage, {required int messageWidth})?
      imageMessageBuilder;

  /// Any message type
  final types.Message message;

  /// Maximum message width
  final int messageWidth;

  // Called when uses taps on an avatar
  final void Function(types.User)? onAvatarTap;

  /// Called when user double taps on any message
  final void Function(BuildContext context, types.Message)? onMessageDoubleTap;

  /// Called when user makes a long press on any message
  final void Function(BuildContext context, types.Message)? onMessageLongPress;

  /// Called when user makes a long press on status icon in any message
  final void Function(BuildContext context, types.Message)?
      onMessageStatusLongPress;

  /// Called when user taps on status icon in any message
  final void Function(BuildContext context, types.Message)? onMessageStatusTap;

  /// Called when user taps on any message
  final void Function(BuildContext context, types.Message)? onMessageTap;

  /// See [TextMessage.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// Rounds border of the message to visually group messages together.
  final bool roundBorder;

  /// Show user avatar for the received message. Useful for a group chat.
  final bool showAvatar;

  /// See [TextMessage.showName]
  final bool showName;

  /// Show message's status
  final bool showStatus;

  /// Show user avatars for received messages. Useful for a group chat.
  final bool showUserAvatars;

  /// Build a text message inside predefined bubble.
  final Widget Function(
    types.TextMessage, {
    required int messageWidth,
    required bool showName,
  })? textMessageBuilder;

  /// See [TextMessage.usePreviewData]
  final bool usePreviewData;

  Widget _avatarBuilder(BuildContext context) {
    final color = getUserAvatarNameColor(
      message.author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = message.author.imageUrl != null;
    final initials = getUserInitials(message.author);

    // return showAvatar
    //     ?
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 15),
      child: GestureDetector(
        onTap: () => onAvatarTap?.call(message.author),
        child:
            // CachedNetworkImage(
            //   imageUrl: message.author.imageUrl ?? '',
            //   imageBuilder: (context, imageProvider) => Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(7),
            //       image: DecorationImage(
            //         image: imageProvider,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            //   // fit: BoxFit.cover,
            //   errorWidget: (context, url, _) {
            //     return Image.asset(
            //       'assets/images/chatPlaceHolder.png',
            //       fit: BoxFit.cover,
            //       height: 32,
            //       width: 32,
            //     );
            //   },
            // ),
            CircleAvatar(
                backgroundColor: hasImage
                    ? InheritedChatTheme.of(context)
                        .theme
                        .userAvatarImageBackgroundColor
                    : color,
                backgroundImage:
                    hasImage ? NetworkImage(message.author.imageUrl!) : null,
                radius: 16,
                child: !hasImage
                    ? Image.asset(
                        'assets/images/chatPlaceHolder.png',
                        fit: BoxFit.cover,
                      )
                    : null),
      ),
    );
    // : const SizedBox(width: 40);
  }

  Widget _bubbleBuilder(
    BuildContext context,
    BorderRadius borderRadius,
    bool currentUserIsAuthor,
    bool enlargeEmojis,
  ) {
    final theme = InheritedChatTheme.of(context).theme;
    final color =
        getUserAvatarNameColor(message.author, theme.userAvatarNameColors);
    final name = getUserName(message.author);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bubbleBuilder != null
            ? bubbleBuilder!(
                _messageBuilder(),
                message: message,
                nextMessageInGroup: roundBorder,
              )
            : enlargeEmojis && hideBackgroundOnEmojiMessages
                ? _messageBuilder()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: !currentUserIsAuthor
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                      color: !currentUserIsAuthor ||
                              message.type == types.MessageType.image
                          ? Colors.white
                          : const Color(0xFFe8f3f5),
                      border: !currentUserIsAuthor &&
                              message.type != types.MessageType.image
                          ? Border.all(
                              color: const Color(0xFFd0d3d6),
                              width: 1,
                            )
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _messageBuilder(),
                    ),
                  ),
        if (showName)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.5, top: 8),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }

  Widget _messageBuilder() {
    switch (message.type) {
      case types.MessageType.custom:
        final customMessage = message as types.CustomMessage;
        return customMessageBuilder != null
            ? customMessageBuilder!(customMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.file:
        final fileMessage = message as types.FileMessage;
        return fileMessageBuilder != null
            ? fileMessageBuilder!(fileMessage, messageWidth: messageWidth)
            : FileMessage(message: fileMessage);
      case types.MessageType.image:
        final imageMessage = message as types.ImageMessage;
        return imageMessageBuilder != null
            ? imageMessageBuilder!(imageMessage, messageWidth: messageWidth)
            : ImageMessage(message: imageMessage, messageWidth: messageWidth);
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return textMessageBuilder != null
            ? textMessageBuilder!(
                textMessage,
                messageWidth: messageWidth,
                showName: showName,
              )
            : TextMessage(
                emojiEnlargementBehavior: emojiEnlargementBehavior,
                hideBackgroundOnEmojiMessages: hideBackgroundOnEmojiMessages,
                message: textMessage,
                onPreviewDataFetched: onPreviewDataFetched,
                showName: showName,
                usePreviewData: usePreviewData,
              );
      default:
        return const SizedBox();
    }
  }

  Widget _statusBuilder(BuildContext context) {
    switch (message.status) {
      case types.Status.delivered:
      case types.Status.sent:
        return InheritedChatTheme.of(context).theme.deliveredIcon != null
            ? InheritedChatTheme.of(context).theme.deliveredIcon!
            : Image.asset(
                'assets/icon-delivered.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.error:
        return InheritedChatTheme.of(context).theme.errorIcon != null
            ? InheritedChatTheme.of(context).theme.errorIcon!
            : Image.asset(
                'assets/icon-error.png',
                color: InheritedChatTheme.of(context).theme.errorColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.seen:
        return InheritedChatTheme.of(context).theme.seenIcon != null
            ? InheritedChatTheme.of(context).theme.seenIcon!
            : Image.asset(
                'assets/icon-seen.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.sending:
        return InheritedChatTheme.of(context).theme.sendingIcon != null
            ? InheritedChatTheme.of(context).theme.sendingIcon!
            : Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InheritedChatTheme.of(context).theme.primaryColor,
                    ),
                  ),
                ),
              );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _currentUserIsAuthor = _user.id == message.author.id;
    final _enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            message is types.TextMessage &&
            isConsistsOfEmojis(
                emojiEnlargementBehavior, message as types.TextMessage);
    final _messageBorderRadius =
        InheritedChatTheme.of(context).theme.messageBorderRadius;
    final _borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(
        _currentUserIsAuthor || roundBorder ? _messageBorderRadius : 0,
      ),
      bottomRight: Radius.circular(_currentUserIsAuthor
          ? roundBorder
              ? _messageBorderRadius
              : 0
          : _messageBorderRadius),
      topLeft: Radius.circular(_messageBorderRadius),
      topRight: Radius.circular(_messageBorderRadius),
    );

    return Container(
      alignment:
          _currentUserIsAuthor ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.only(
        bottom: 4,
        left: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_currentUserIsAuthor && showUserAvatars) _avatarBuilder(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: messageWidth.toDouble(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onDoubleTap: () => onMessageDoubleTap?.call(context, message),
                  onLongPress: () => onMessageLongPress?.call(context, message),
                  onTap: () => onMessageTap?.call(context, message),
                  child: _bubbleBuilder(
                    context,
                    _borderRadius,
                    _currentUserIsAuthor,
                    _enlargeEmojis,
                  ),
                ),
              ],
            ),
          ),
          if (_currentUserIsAuthor)
            Padding(
              padding: InheritedChatTheme.of(context).theme.statusIconPadding,
              child: showStatus
                  ? GestureDetector(
                      onLongPress: () =>
                          onMessageStatusLongPress?.call(context, message),
                      onTap: () => onMessageStatusTap?.call(context, message),
                      child: _statusBuilder(context),
                    )
                  : null,
            ),
        ],
      ),
    );
  }
}
