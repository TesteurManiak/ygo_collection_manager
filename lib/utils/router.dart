import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/ui/card_view/card_view.dart';
import 'package:ygo_collection_manager/ui/common/cards_overlay.dart';
import 'package:ygo_collection_manager/ui/expansion_view/expansion_view.dart';
import 'package:ygo_collection_manager/ui/loading_view/loading_view.dart';
import 'package:ygo_collection_manager/ui/root_view/root_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoadingView.routeName:
      return MaterialPageRoute(builder: (_) => LoadingView());
    case RootView.routeName:
      return MaterialPageRoute(builder: (_) => RootView());
    case ExpansionView.routeName:
      return MaterialPageRoute<SetModel>(
        builder: (_) => ExpansionView(settings.arguments! as SetModel),
      );
    case CardView.routeName:
      return MaterialPageRoute<CardInfoModel>(
        builder: (_) => CardView(card: settings.arguments! as CardInfoModel),
      );
    case CardsOverlay.routeName:
      final args = settings.arguments! as List<Object>;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => CardsOverlay(
          cards: args[0] as List<CardInfoModel>,
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
