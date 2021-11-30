import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/card_banlist_info.dart';

void main() {
  group('CardBanlistInfo', () {
    test('compare instances with same props', () {
      const tCardBanlistInfo = CardBanlistInfo(
        goat: '',
        ocg: '',
        tcg: '',
      );
      const tCardBanlistInfo2 = CardBanlistInfo(
        goat: '',
        ocg: '',
        tcg: '',
      );
      expect(tCardBanlistInfo, tCardBanlistInfo2);
      expect(tCardBanlistInfo.props, tCardBanlistInfo2.props);
    });
  });
}
