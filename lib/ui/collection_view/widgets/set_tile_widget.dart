import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class SetTileWidget extends StatelessWidget {
  final SetModel set;

  const SetTileWidget(this.set);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: DynamicThemedColors.cardSetBorder(context),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(set.setName),
                    Text('0 / ${set.numOfCards}'),
                  ],
                ),
              ),
              const Text('0%'),
            ],
          ),
        ),
      ),
    );
  }
}
