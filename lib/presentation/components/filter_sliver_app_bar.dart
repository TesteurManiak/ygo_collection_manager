import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'filter_field.dart';

class FilterSliverAppBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const FilterSliverAppBar({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: kToolbarHeight + 4,
      backgroundColor: DynamicThemedColors.scaffoldBackground(context),
      pinned: true,
      title: FilterField(
        hintText: hintText,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
