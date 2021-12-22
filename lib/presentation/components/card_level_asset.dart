import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';

class CardLevelAsset extends StatelessWidget {
  final String asset;

  const CardLevelAsset({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyEdgeInsets.symH4,
      child: Image.asset(asset, height: Consts.px20),
    );
  }
}
