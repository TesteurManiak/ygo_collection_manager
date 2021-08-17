import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class SliverSpacer extends StatelessWidget {
  final double? height;
  final double? width;

  const SliverSpacer({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          border: Border.all(
            color: DynamicThemedColors.scaffoldBackground(context),
          ),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
