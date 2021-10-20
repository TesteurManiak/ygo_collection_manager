import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/ui/common/card_bottom_sheet.dart';

class CardsOverlay extends StatefulWidget {
  static const routeName = '/cards-overlay';

  final int initialIndex;
  final List<CardInfoModel> cards;

  const CardsOverlay({Key? key, this.initialIndex = 0, required this.cards})
      : super(key: key);

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
    duration: const Duration(milliseconds: 500),
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
            itemBuilder: (_, index) => _CardOverlay(widget.cards[index]),
            itemCount: widget.cards.length,
          ),
        ),
      ),
    );
  }
}

class _CardOverlay extends StatefulWidget {
  final CardInfoModel card;

  const _CardOverlay(this.card);

  @override
  State<StatefulWidget> createState() => _CardOverlayState();
}

class _CardOverlayState extends State<_CardOverlay>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
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
          child: Container(
            margin: const EdgeInsets.all(8.0),
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
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
