import 'dart:convert';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';
import 'package:ygo_collection_manager/presentation/components/card_detail_widget.dart';

import '../../utils/fixture_reader.dart';

void main() {
  group('CardDetailWidget: Golden Tests', () {
    final tJson = jsonDecode(fixture('cardinfo.json')) as Map<String, dynamic>;
    final tCardJson = (tJson['data'] as Iterable).first as Map<String, dynamic>;
    final tCard = YgoCardModel.fromJson(tCardJson);

    goldenTest(
      'renders correctly',
      fileName: 'card_detail_widget',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'archetype',
            child: CardDetailWidget(
              label: 'Archetype',
              value: tCard.name,
            ),
          ),
          GoldenTestScenario(
            name: 'formats',
            child: CardDetailWidget(
              label: 'Formats',
              value: tCard.miscInfo!
                  .map<List<String>>((e) => e.formats)
                  .reduce((a, b) => [...a, ...b])
                  .toSet()
                  .join(', '),
            ),
          ),
          GoldenTestScenario(
            name: 'atk',
            child: CardDetailWidget(
              label: 'Atk',
              value: tCard.atk!.toString(),
            ),
          ),
          GoldenTestScenario(
            name: 'def',
            child: CardDetailWidget(
              label: 'Def',
              value: tCard.def!.toString(),
            ),
          ),
        ],
      ),
    );
  });
}
