import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../constants/colors.dart';

class TopRoundedSliver extends StatelessWidget {
  final double borderRadius;

  const TopRoundedSliver({
    Key? key,
    this.borderRadius = Consts.px20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: MyEdgeInsets.onlyT16,
        color: Theme.of(context).appBarTheme.backgroundColor,
        height: Consts.px20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: Consts.px20,
              decoration: BoxDecoration(
                color: DynamicThemedColors.scaffoldBackground(context),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
