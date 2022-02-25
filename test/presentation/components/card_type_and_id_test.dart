import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/components/card_type_and_id.dart';

void main() {
  group('CardTypeAndId: Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'card_type_and_id',
      widget: GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'Tornado Dragon',
            child: const CardTypeAndId(
              type: 'XYZ Monster',
              id: 6983839,
            ),
          )
        ],
      ),
    );
  });
}
