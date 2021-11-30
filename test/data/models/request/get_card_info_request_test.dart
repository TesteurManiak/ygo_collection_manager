import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/core/entities/banlist.dart';
import 'package:ygo_collection_manager/core/entities/format.dart';
import 'package:ygo_collection_manager/core/entities/link_markers.dart';
import 'package:ygo_collection_manager/core/entities/sort.dart';
import 'package:ygo_collection_manager/data/models/request/get_card_info_request.dart';

void main() {
  group('GetCardInfoRequest', () {
    test('compare instances with same props', () {
      final a = GetCardInfoRequest(
        names: List<String>.generate(10, (i) => 'name$i'),
        fname: 'fname',
      );
      final b = GetCardInfoRequest(
        names: List<String>.generate(10, (i) => 'name$i'),
        fname: 'fname',
      );
      expect(a, b);
      expect(a.props, b.props);
    });
  });

  group('Banlist', () {
    test('getter string', () {
      expect(Banlist.tcg.string, 'TCG');
      expect(Banlist.ocg.string, 'OCG');
      expect(Banlist.goat.string, 'GOAT');
    });
  });

  group('LinkMarkers', () {
    test('getter string', () {
      expect(LinkMarkers.top.string, 'Top');
      expect(LinkMarkers.bottom.string, 'Bottom');
      expect(LinkMarkers.left.string, 'Left');
      expect(LinkMarkers.right.string, 'Right');
      expect(LinkMarkers.topLeft.string, 'Top-Left');
      expect(LinkMarkers.topRight.string, 'Top-Right');
      expect(LinkMarkers.bottomLeft.string, 'Bottom-Left');
      expect(LinkMarkers.bottomRight.string, 'Bottom-Right');
    });
  });

  group('Sort', () {
    test('getter string', () {
      expect(Sort.atk.string, 'atk');
      expect(Sort.def.string, 'def');
      expect(Sort.name.string, 'name');
      expect(Sort.type.string, 'type');
      expect(Sort.level.string, 'level');
      expect(Sort.id.string, 'id');
      expect(Sort.newest.string, 'new');
    });
  });

  group('Format', () {
    test('getter string', () {
      expect(Format.tcg.string, 'tcg');
      expect(Format.goat.string, 'goat');
      expect(Format.ocgGoat.string, 'ocg goat');
      expect(Format.speedDuel.string, 'speed duel');
      expect(Format.rushDuel.string, 'rush duel');
      expect(Format.duelLinks.string, 'duel links');
    });
  });
}
