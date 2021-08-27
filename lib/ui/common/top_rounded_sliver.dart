import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class TopRoundedSliver extends StatelessWidget {
  final double borderRadius;

  const TopRoundedSliver({this.borderRadius = 20});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        color: Theme.of(context).appBarTheme.backgroundColor,
        height: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 20,
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
