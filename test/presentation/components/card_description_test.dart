import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/components/card_description.dart';

void main() {
  group('CardDescription: Golden Tests', () {
    const tDesc =
        '2 Level 4 monsters\nOnce per turn (Quick Effect): You can detach 1 material from this card, then target 1 Spell/Trap on the field; destroy it.';

    goldenTest(
      'renders correctly',
      fileName: 'card_description',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'tornado dragon desc',
            child: const CardDescription(desc: tDesc),
          ),
        ],
      ),
    );
  });
}
