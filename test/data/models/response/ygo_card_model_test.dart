import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/data/models/response/ygo_card_model.dart';

import '../../../utils/fixture_reader.dart';

void main() {
  group('YgoCardModel', () {
    group('fromJson', () {
      final tJson =
          jsonDecode(fixture('cardinfo.json')) as Map<String, dynamic>;
      final tCardJson =
          (tJson['data'] as Iterable).first as Map<String, dynamic>;

      test('fixture: cardinfo.json', () {
        final card = YgoCardModel.fromJson(tCardJson);
        expect(card.id, 6983839);
      });
    });
  });
}
