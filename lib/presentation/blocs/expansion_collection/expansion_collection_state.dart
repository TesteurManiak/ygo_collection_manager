part of 'expansion_collection_bloc.dart';

enum ExpansionCollectionStatus { initial, loading, loaded, error }

abstract class ExpansionCollectionState
    extends BlocState<ExpansionCollectionStatus> {
  const ExpansionCollectionState();
}

class ExpansionCollectionInitial extends ExpansionCollectionState {
  @override
  final ExpansionCollectionStatus status;

  const ExpansionCollectionInitial()
      : status = ExpansionCollectionStatus.initial;
}
