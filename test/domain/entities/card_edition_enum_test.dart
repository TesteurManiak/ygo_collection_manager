import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/card_edition_enum.dart';

void main() {
  group('CardEditionEnum', () {
    test('getter string', () {
      expect(CardEditionEnum.first.string, '1st Edition');
      expect(CardEditionEnum.unlimited.string, 'Unlimited');
    });
  });
}
