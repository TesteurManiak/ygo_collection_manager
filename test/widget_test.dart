import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

void main() {
  test('CardInfoModel parsing', () async {
    final text =
        await File('test/test_resources/big_fat_json.json').readAsString();
    final json = jsonDecode(text) as Map<String, dynamic>;

    (json['data'] as Iterable).map<CardInfoModel>(
        (e) => CardInfoModel.fromJson(e as Map<String, dynamic>));
  });
}
