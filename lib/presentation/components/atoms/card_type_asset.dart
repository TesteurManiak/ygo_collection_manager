import 'package:flutter/material.dart';

import '../../../core/consts/consts.dart';

class CardTypeAsset extends StatelessWidget {
  final String type;

  const CardTypeAsset({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/type/$type.jpg',
      height: Consts.px20,
      errorBuilder: (_, __, ___) => const SizedBox(),
    );
  }
}
