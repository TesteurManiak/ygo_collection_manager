import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

class CardsOverlay extends StatefulWidget {
  final int initialIndex;

  const CardsOverlay({this.initialIndex = 0});

  @override
  State<StatefulWidget> createState() => _CardsOverlayState();
}

class _CardsOverlayState extends State<CardsOverlay> {
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  late final _pageController = PageController(
    keepPage: false,
    viewportFraction: 0.8,
    initialPage: widget.initialIndex,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _cardsBloc.closeOverlay,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (_, index) => _CardOverlay(_cardsBloc.cards![index]),
        itemCount: _cardsBloc.cards!.length,
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
    with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
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
    );
  }
}
