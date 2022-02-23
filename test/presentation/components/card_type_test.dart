import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/components/card_type.dart';

void main() {
  group('CardType: Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'card_type',
      widget: GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'XYZ Monster',
            child: const CardType(type: 'XYZ Monster'),
          ),
        ],
      ),
    );
  });
}
