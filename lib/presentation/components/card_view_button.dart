import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/consts/consts.dart';
import '../../domain/entities/ygo_card.dart';
import '../card_view/card_view.dart';
import '../constants/colors.dart';

class CardViewButton extends StatelessWidget {
  final String? setId;
  final YgoCard card;

  const CardViewButton({
    Key? key,
    required this.setId,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.px20),
        ),
      ),
      onPressed: () {
        final _setId = setId;
        if (_setId != null) {
          context.pushNamed(
            CardView.routeName,
            params: CardView.routeParams(card),
          );
        } else {
          context.goNamed(
            CardView.routeName,
            params: CardView.routeParams(card),
          );
        }
      },
      child: const Text(
        'VIEW',
        style: TextStyle(color: MyColors.yellow),
      ),
    );
  }
}
