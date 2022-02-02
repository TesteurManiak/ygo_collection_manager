import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';

void main() {
  group('levelAsset property', () {
    const tCard = YgoCard(
      id: 0,
      name: '',
      type: 'XYZ Monster',
      desc: '',
      atk: null,
      def: null,
      level: null,
      race: '',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: null,
    );
    const tCard2 = YgoCard(
      id: 0,
      name: '',
      type: 'xyz Monster',
      desc: '',
      atk: null,
      def: null,
      level: null,
      race: '',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: null,
    );
    const tCard3 = YgoCard(
      id: 0,
      name: '',
      type: 'Monster',
      desc: '',
      atk: null,
      def: null,
      level: null,
      race: '',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: null,
    );
    const tAsset = 'assets/level/rank.png';

    test('return rank.png if type contains "XYZ" or "xyz"', () {
      expect(tCard.levelAsset, tAsset);
      expect(tCard2.levelAsset, tAsset);
    });

    test('return level.png otherwise', () {
      expect(tCard3.levelAsset, 'assets/level/level.png');
    });
  });

  group('props property', () {
    const tCard = YgoCard(
      id: 0,
      name: '',
      type: 'XYZ Monster',
      desc: '',
      atk: null,
      def: null,
      level: null,
      race: '',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: null,
    );
    const tCard2 = YgoCard(
      id: 0,
      name: '',
      type: 'XYZ Monster',
      desc: '',
      atk: null,
      def: null,
      level: null,
      race: '',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: null,
    );
    const tCard3 = YgoCard(
      id: 0,
      name: '',
      type: 'Monster',
      desc: '',
      atk: null,
      def: null,
      level: null,
      race: '',
      attribute: null,
      archetype: null,
      scale: null,
      linkval: null,
      cardImages: [],
      linkmarkers: null,
      cardSets: null,
      cardPrices: [],
      banlistInfo: null,
      miscInfo: null,
    );

    test('Same props = same object', () {
      expect(tCard.props, tCard.props);
    });

    test('Different props = different object', () {
      expect(tCard3.props, isNot(tCard2.props));
    });
  });
}
