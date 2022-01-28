import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_collection_manager/presentation/loading_view/loading_state_info.dart';

void main() {
  test("initialized to false", () {
    final loadingState = LoadingStateInfo();

    expect(loadingState.hasLoaded, false);

    loadingState.dispose();
  });

  group("finishedLoading()", () {
    test("set hasLoaded to true", () {
      final loadingState = LoadingStateInfo()..finishedLoading();

      expect(loadingState.hasLoaded, true);

      loadingState.dispose();
    });
  });
}
