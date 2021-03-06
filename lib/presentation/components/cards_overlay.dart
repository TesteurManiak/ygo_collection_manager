import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../core/consts/durations.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../domain/entities/ygo_card.dart';
import 'card_bottom_sheet.dart';

class CardsOverlay extends StatefulWidget {
  static const routeName = '/cards-overlay';

  final int initialIndex;
  final List<YgoCard> cards;
  final String? setId;

  const CardsOverlay({
    Key? key,
    this.initialIndex = 0,
    required this.cards,
    this.setId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardsOverlayState();
}

class _CardsOverlayState extends State<CardsOverlay>
    with SingleTickerProviderStateMixin {
  late final _pageController = PageController(
    initialPage: widget.initialIndex,
  );
  late final _overlayAnimationController = AnimationController(
    vsync: this,
    duration: Durations.ms500,
    value: 1.0,
  );
  late final _overlayAnimation = CurvedAnimation(
    parent: _overlayAnimationController,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    await _overlayAnimationController.reverse();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: FadeTransition(
        opacity: _overlayAnimation,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _overlayAnimationController
                  .reverse()
                  .then((_) => Navigator.pop(context)),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.8),
          body: PageView.builder(
            controller: _pageController,
            itemBuilder: (_, index) => _CardOverlay(
              card: widget.cards[index],
              setId: widget.setId,
            ),
            itemCount: widget.cards.length,
          ),
        ),
      ),
    );
  }
}

class _CardOverlay extends StatefulWidget {
  final YgoCard card;
  final String? setId;

  const _CardOverlay({required this.card, this.setId});

  @override
  State<StatefulWidget> createState() => _CardOverlayState();
}

class _CardOverlayState extends State<_CardOverlay>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  late final _animationController = AnimationController(
    vsync: this,
    duration: Durations.ms500,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        ScaleTransition(
          scale: CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeIn,
          ),
          child: Padding(
            padding: MyEdgeInsets.all8,
            child: CachedNetworkImage(
              imageUrl: widget.card.cardImages.first.imageUrl,
              placeholder: (_, __) => Image.asset(
                'assets/back_high.jpg',
              ),
            ),
          ),
        ),
        SnappingSheet(
          lockOverflowDrag: true,
          snappingPositions: const [
            SnappingPosition.factor(
              positionFactor: 0.12,
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
            SnappingPosition.factor(positionFactor: 0.5),
            SnappingPosition.factor(positionFactor: 1.0),
          ],
          sheetBelow: SnappingSheetContent(
            childScrollController: _scrollController,
            draggable: true,
            child: CardBottomSheet(
              card: widget.card,
              controller: _scrollController,
              setId: widget.setId,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
