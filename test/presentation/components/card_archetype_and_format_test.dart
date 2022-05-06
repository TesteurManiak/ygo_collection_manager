import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/domain/entities/card_misc_info.dart';
import 'package:ygo_collection_manager/presentation/components/card_archetype_and_formats.dart';

void main() {
  group('CardArchetypeAndFormats: Golden Tests', () {
    final tTcgDate = DateTime.now();
    final tOcgDate = DateTime.now();

    goldenTest(
      'renders correctly',
      fileName: 'card_archetype_and_formats',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'with archetype',
            child: const CardArchetypeAndFormats(
              archetype: 'Harpie',
              miscInfos: null,
            ),
          ),
          GoldenTestScenario(
            name: 'with archetype and miscInfos',
            child: CardArchetypeAndFormats(
              archetype: 'Harpie',
              miscInfos: [
                CardMiscInfo(
                  views: 12345,
                  betaName: null,
                  staple: null,
                  viewsWeek: 152,
                  upvotes: 11,
                  downvotes: 0,
                  formats: const ['OCG', 'TCG'],
                  betaId: null,
                  tcgDate: tTcgDate,
                  ocgDate: tOcgDate,
                  konamiId: null,
                  hasEffect: null,
                  treatedAs: 'Harpie Lady',
                )
              ],
            ),
          ),
        ],
      ),
    );
  });
}
