part of 'sets_bloc.dart';

enum SetsStatus { initial, loading, loaded, error }

abstract class SetsState extends BlocState<SetsStatus> {
  const SetsState();
}

class SetsInitial extends SetsState {
  @override
  final SetsStatus status;

  const SetsInitial() : status = SetsStatus.initial;
}
