import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import '../global/colors.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// Animated list which handles automatic animations and pagination
class ChatList extends StatefulWidget {
  /// Creates a chat list widget
  const ChatList({
    Key? key,
    this.isLastPage,
    required this.itemBuilder,
    required this.items,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.scrollPhysics,
  }) : super(key: key);

  /// Used for pagination (infinite scroll) together with [onEndReached].
  /// When true, indicates that there are no more pages to load and
  /// pagination will not be triggered.
  final bool? isLastPage;

  /// Items to build
  final List<Object> items;

  /// Item builder
  final Widget Function(Object, int? index) itemBuilder;

  /// Used for pagination (infinite scroll). Called when user scrolls
  /// to the very end of the list (minus [onEndReachedThreshold]).
  final Future<void> Function()? onEndReached;

  /// Used for pagination (infinite scroll) together with [onEndReached].
  /// Can be anything from 0 to 1, where 0 is immediate load of the next page
  /// as soon as scroll starts, and 1 is load of the next page only if scrolled
  /// to the very end of the list. Default value is 0.75, e.g. start loading
  /// next page when scrolled through about 3/4 of the available content.
  final double? onEndReachedThreshold;

  /// Determines the physics of the scroll view
  final ScrollPhysics? scrollPhysics;

  @override
  _ChatListState createState() => _ChatListState();
}

/// [ChatList] widget state
class _ChatListState extends State<ChatList>
    with SingleTickerProviderStateMixin {
  bool _isNextPageLoading = false;
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  late List<Object> _oldData = List.from(widget.items);
  final _scrollController = ScrollController();
  // final _autoScrollController = AutoScrollController();
  late final AnimationController _controller = AnimationController(vsync: this);

  late final Animation<double> _animation = CurvedAnimation(
    curve: Curves.easeOutQuad,
    parent: _controller,
  );
  bool _showAppBar = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    didUpdateWidget(widget);
  }

  void _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.maxScrollExtent - 200 &&
        _showAppBar == false) {
      setState(() {
        _showAppBar = true;
      });
    } else if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 200 &&
        _showAppBar == true) {
      setState(() {
        _showAppBar = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _calculateDiffs(oldWidget.items);
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _calculateDiffs(List<Object> oldList) async {
    final diffResult = calculateListDiff<Object>(
      oldList,
      widget.items,
      equalityChecker: (item1, item2) {
        if (item1 is Map<String, Object> && item2 is Map<String, Object>) {
          final message1 = item1['message']! as types.Message;
          final message2 = item2['message']! as types.Message;

          return message1.id == message2.id;
        } else {
          return item1 == item2;
        }
      },
    );

    for (final update in diffResult.getUpdates(batch: false)) {
      update.when(
        insert: (pos, count) {
          _listKey.currentState?.insertItem(pos);
        },
        remove: (pos, count) {
          final item = oldList[pos];
          _listKey.currentState?.removeItem(
            pos,
            (_, animation) => _removedMessageBuilder(item, animation),
          );
        },
        change: (pos, payload) {},
        move: (from, to) {},
      );
    }

    _scrollToBottomIfNeeded(oldList);

    _oldData = List.from(widget.items);
  }

  Widget _newMessageBuilder(int index, Animation<double> animation) {
    try {
      final item = _oldData[index];

      return SizeTransition(
        axisAlignment: -1,
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
        child: widget.itemBuilder(item, index),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  Widget _removedMessageBuilder(Object item, Animation<double> animation) {
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInQuad)),
      child: FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
        child: widget.itemBuilder(item, null),
      ),
    );
  }

  // Hacky solution to reconsider
  void _scrollToBottomIfNeeded(List<Object> oldList) {
    try {
      // Take index 1 because there is always a spacer on index 0
      final oldItem = oldList[1];
      final item = widget.items[1];

      if (oldItem is Map<String, Object> && item is Map<String, Object>) {
        final oldMessage = oldItem['message']! as types.Message;
        final message = item['message']! as types.Message;

        // Compare items to fire only on newly added messages
        if (oldMessage != message) {
          // Run only for sent message
          if (message.author.id == InheritedUser.of(context).user.id) {
            // Delay to give some time for Flutter to calculate new
            // size after new message was added
            Future.delayed(const Duration(milliseconds: 100), () {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInQuad,
                );
              }
            });
          }
        }
      }
    } catch (e) {
      // Do nothing if there are no items
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (widget.onEndReached == null || widget.isLastPage == true) {
          return false;
        }

        if (notification.metrics.pixels >=
            (notification.metrics.maxScrollExtent *
                (widget.onEndReachedThreshold ?? 0.75))) {
          if (widget.items.isEmpty || _isNextPageLoading) return false;

          _controller.duration = const Duration();
          _controller.forward();

          setState(() {
            _isNextPageLoading = true;
          });

          widget.onEndReached!().whenComplete(() {
            _controller.duration = const Duration(milliseconds: 300);
            _controller.reverse();

            setState(() {
              _isNextPageLoading = false;
            });
          });
        }

        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          flexibleSpace: AnimatedContainer(
            color: _showAppBar ? Colors.white : Colors.white.withOpacity(0),
            duration: const Duration(milliseconds: 150),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: MaterialButton(
              elevation: 0,
              onPressed: () {
                Navigator.maybePop(context);
              },
              color: AppColors.greyF2F3F3,
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black45515D,
                size: 24,
              ),
              padding: const EdgeInsets.all(8.0),
              shape: const CircleBorder(),
            ),
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          reverse: true,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 4),
              sliver: SliverAnimatedList(
                initialItemCount: widget.items.length,
                key: _listKey,
                itemBuilder: (_, index, animation) =>
                    _newMessageBuilder(index, animation),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: _animation,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: 32,
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: _isNextPageLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  InheritedChatTheme.of(context)
                                      .theme
                                      .primaryColor,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _appBar(context),
          ],
        ),
      ),
    );
  }
}

SliverAppBar _appBar(BuildContext context) {
  return SliverAppBar(
    pinned: true,
    snap: false,
    floating: true,
    centerTitle: false,
    automaticallyImplyLeading: false,
    elevation: 0,
    stretch: true,
    backgroundColor: Colors.white,
    expandedHeight: 200,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 37),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.blueE8F3F5,
              AppColors.blue8DC4CB,
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Let\'s ',
              style: TextStyle(
                fontSize: 36,
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.w300,
                color: AppColors.black45515D,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'chat 🤗',
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
      ),
      stretchModes: const [
        StretchMode.zoomBackground,
      ],
    ),
  );
}
