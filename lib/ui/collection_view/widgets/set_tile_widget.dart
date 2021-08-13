import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class SetTileWidget extends StatelessWidget {
  final SetModel set;

  const SetTileWidget(this.set);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
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
    );
  }
}
