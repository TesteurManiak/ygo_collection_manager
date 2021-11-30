import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/card_misc_info.dart';

void main() {
  group('CardMiscInfo', () {
    test('compare instances with same props', () {
      final now = DateTime.now();
      final a = CardMiscInfo(
        views: 0,
        betaName: null,
        staple: null,
        viewsWeek: 10,
        upvotes: 56,
        downvotes: 13,
        formats: const [],
        betaId: null,
        tcgDate: now,
        ocgDate: now,
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
        formats: const [],
        betaId: null,
        tcgDate: now,
        ocgDate: now,
        konamiId: null,
        hasEffect: null,
        treatedAs: null,
      );
      expect(a, b);
      expect(a.props, b.props);
    });
  });
}
