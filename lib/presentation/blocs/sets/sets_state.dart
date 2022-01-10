part of 'sets_bloc.dart';

enum SetsStatus { initial, loading, loaded, filtered, error }

abstract class SetsState extends BlocState<SetsStatus> {
  const SetsState();
}

class SetsInitial extends SetsState {
  @override
  final status = SetsStatus.initial;

  const SetsInitial();
}

class SetsLoading extends SetsState {
  @override
  final status = SetsStatus.loading;

  const SetsLoading();
}

class SetsLoaded extends SetsState {
  final List<YgoSet> sets;

  const SetsLoaded(this.sets);

  @override
  final status = SetsStatus.loaded;

  @override
  List<Object?> get props => [status, sets];
}

class SetsFiltered extends SetsState {
  final List<YgoSet> sets;

  const SetsFiltered(this.sets);

  @override
  final status = SetsStatus.filtered;

  @override
  List<Object?> get props => [status, sets];
}

class SetsError extends SetsState {
  final String message;

  const SetsError(this.message);

  @override
  final status = SetsStatus.error;

  @override
  List<Object?> get props => [status, message];
}
