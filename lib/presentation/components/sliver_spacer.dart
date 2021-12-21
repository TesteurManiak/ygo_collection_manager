import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SliverSpacer extends StatelessWidget {
  final double? height;
  final double? width;

  const SliverSpacer({Key? key, this.height, this.width}) : super(key: key);

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
