import 'package:flutter/material.dart';
import 'inherited_chat_theme.dart';
import 'inherited_l10n.dart';

/// A class that represents attachment button widget
class AttachmentButton extends StatelessWidget {
  /// Creates attachment button widget
  const AttachmentButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  /// Callback for attachment button tap event
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(
          right: 6,
        ),
        height: MediaQuery.of(context).size.height * 0.04433498,
        width: MediaQuery.of(context).size.width * 0.096,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF8DC4CB),
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Color(0xFF8DC4CB),
          size: 24,
        ),
      ),
    );
    // Container(
    //   height: 24,
    //   margin: const EdgeInsets.only(right: 16),
    //   width: 24,
    //   child: IconButton(
    //     icon: InheritedChatTheme.of(context).theme.attachmentButtonIcon != null
    //         ? InheritedChatTheme.of(context).theme.attachmentButtonIcon!
    //         : Image.asset(
    //             'assets/icon-attachment.png',
    //             color: InheritedChatTheme.of(context).theme.inputTextColor,
    //             package: 'flutter_chat_ui',
    //           ),
    //     onPressed: onPressed,
    //     padding: EdgeInsets.zero,
    //     tooltip:
    //         InheritedL10n.of(context).l10n.attachmentButtonAccessibilityLabel,
    //   ),
    // );
  }
}
