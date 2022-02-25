import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/components/card_type_asset.dart';

import '../../utils/test_asset_bundle.dart';

void main() {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  group('CardTypeAsset: Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'card_type_asset',
      widget: GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'XYZ Monster',
            child: DefaultAssetBundle(
              bundle: TestAssetBundle(),
              child: const CardTypeAsset(type: 'XYZ Monster'),
            ),
          ),
        ],
      ),
    );
  });
}
