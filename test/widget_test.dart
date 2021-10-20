import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

void main() {
  group('Parsing', () {
    test('Legend of Blue Eyes White Dragon', () async {
      final text =
          await File('test/test_resources/lob_cards_list.json').readAsString();
      final json = jsonDecode(text) as Map<String, dynamic>;
      final cards = (json['data'] as Iterable)
          .map<CardInfoModel>(
            (e) => CardInfoModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      expect(cards.length, 126);
    });
  });
}
