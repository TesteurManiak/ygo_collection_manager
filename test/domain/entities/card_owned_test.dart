import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/card_edition_enum.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';

void main() {
  group('key property', () {
    const tSetCode = 'ABC';
    const edition = CardEditionEnum.first;
    const tOwnedCard = CardOwned(
      quantity: 0,
      setCode: tSetCode,
      edition: edition,
      setName: '',
      id: 0,
    );

    test('formatted from setCode and edition', () {
      expect(tOwnedCard.key, '$tSetCode-${edition.string}');
    });
  });

  group('props property', () {
    const tOwnedCard = CardOwned(
      quantity: 0,
      setCode: '',
      edition: CardEditionEnum.first,
      setName: '',
      id: 0,
    );
    const tOwnedCard2 = CardOwned(
      quantity: 0,
      setCode: '',
      edition: CardEditionEnum.first,
      setName: '',
      id: 0,
    );
    const tOwnedCard3 = CardOwned(
      quantity: 0,
      setCode: '',
      edition: CardEditionEnum.unlimited,
      setName: '',
      id: 0,
    );

    test('Same props = same object', () {
      expect(tOwnedCard.props, tOwnedCard2.props);
    });

    test('Different props = different object', () {
      expect(tOwnedCard3.props, isNot(tOwnedCard2.props));
    });
  });
}
