import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class CardDescription extends StatelessWidget {
  final String desc;

  const CardDescription({Key? key, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 28),
      child: Text(desc, style: TextStyles.grey14),
    );
  }
}
