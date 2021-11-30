import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/card_misc_info.dart';

void main() {
  group('CardMiscInfo', () {
    test('compare instances with same props', () {
      final a = CardMiscInfo(
        views: 0,
        betaName: null,
        staple: null,
        viewsWeek: 10,
        upvotes: 56,
        downvotes: 13,
        formats: [],
        betaId: null,
        tcgDate: DateTime.now(),
        ocgDate: DateTime.now(),
        konamiId: null,
        hasEffect: null,
        treatedAs: null,
      );
      final b = CardMiscInfo(
        views: 0,
        betaName: null,
        staple: null,
        viewsWeek: 10,
        upvotes: 56,
        downvotes: 13,
        formats: [],
        betaId: null,
        tcgDate: DateTime.now(),
        ocgDate: DateTime.now(),
        konamiId: null,
        hasEffect: null,
        treatedAs: null,
      );
      expect(a, b);
      expect(a.props, b.props);
    });
  });
}
