// Mocks generated by Mockito 5.0.17 from annotations
// in ygo_collection_manager/test/presentation/router_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:ygo_collection_manager/domain/entities/card_owned.dart' as _i9;
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart' as _i7;
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart' as _i5;
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart'
    as _i2;
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart'
    as _i6;
import 'package:ygo_collection_manager/domain/usecases/fetch_all_sets.dart'
    as _i3;
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart'
    as _i8;
import 'package:ygo_collection_manager/domain/usecases/should_reload_db.dart'
    as _i10;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeYgoProRepository_0 extends _i1.Fake implements _i2.YgoProRepository {
}

/// A class which mocks [FetchAllSets].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchAllSets extends _i1.Mock implements _i3.FetchAllSets {
  MockFetchAllSets() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.YgoProRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeYgoProRepository_0()) as _i2.YgoProRepository);
  @override
  _i4.Future<List<_i5.YgoSet>> call({bool? shouldReload}) =>
      (super.noSuchMethod(
              Invocation.method(#call, [], {#shouldReload: shouldReload}),
              returnValue: Future<List<_i5.YgoSet>>.value(<_i5.YgoSet>[]))
          as _i4.Future<List<_i5.YgoSet>>);
}

/// A class which mocks [FetchAllCards].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchAllCards extends _i1.Mock implements _i6.FetchAllCards {
  MockFetchAllCards() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.YgoProRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeYgoProRepository_0()) as _i2.YgoProRepository);
  @override
  _i4.Future<List<_i7.YgoCard>> call({bool? shouldReload}) =>
      (super.noSuchMethod(
              Invocation.method(#call, [], {#shouldReload: shouldReload}),
              returnValue: Future<List<_i7.YgoCard>>.value(<_i7.YgoCard>[]))
          as _i4.Future<List<_i7.YgoCard>>);
}

/// A class which mocks [FetchOwnedCards].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchOwnedCards extends _i1.Mock implements _i8.FetchOwnedCards {
  MockFetchOwnedCards() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.YgoProRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeYgoProRepository_0()) as _i2.YgoProRepository);
  @override
  _i4.Future<List<_i9.CardOwned>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue: Future<List<_i9.CardOwned>>.value(<_i9.CardOwned>[]))
          as _i4.Future<List<_i9.CardOwned>>);
}

/// A class which mocks [ShouldReloadDb].
///
/// See the documentation for Mockito's code generation for more information.
class MockShouldReloadDb extends _i1.Mock implements _i10.ShouldReloadDb {
  MockShouldReloadDb() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.YgoProRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeYgoProRepository_0()) as _i2.YgoProRepository);
  @override
  _i4.Future<bool> call() => (super.noSuchMethod(Invocation.method(#call, []),
      returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}
