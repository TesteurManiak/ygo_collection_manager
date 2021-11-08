import 'package:flutter/material.dart';

import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../presentation/card_view/card_view.dart';
import '../../presentation/common/cards_overlay.dart';
import '../../presentation/expansion_view/expansion_view.dart';
import '../../presentation/loading_view/loading_view.dart';
import '../../presentation/root_view/root_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoadingView.routeName:
      return MaterialPageRoute(builder: (_) => const LoadingView());
    case RootView.routeName:
      return MaterialPageRoute(builder: (_) => const RootView());
    case ExpansionView.routeName:
      return MaterialPageRoute<YgoSet>(
        builder: (_) => ExpansionView(settings.arguments! as YgoSet),
      );
    case CardView.routeName:
      final args = settings.arguments! as List<Object>;
      return MaterialPageRoute(
        builder: (_) => CardView(
          card: args[0] as YgoCard,
          totalOwnedCard: args[1] as ValueNotifier<int>,
        ),
      );
    case CardsOverlay.routeName:
      final args = settings.arguments! as List<Object>;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => CardsOverlay(
          cards: args[0] as List<YgoCard>,
          initialIndex: args[1] as int,
        ),
        opaque: false,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
