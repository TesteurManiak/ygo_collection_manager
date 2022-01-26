import 'package:equatable/equatable.dart';

/// This base bloc state class is used to force an implementation of the
/// Equatable interface with a [status] property.
///
/// ### Code Sample
///
/// ```dart
/// enum MyEnumStatus { initial, loading, loaded, error }
///
/// abstract class MyBlocState extends BlocState<MyEnumStatus> {}
///
/// class InitialState extends MyBlocState {
///   @override
///   final MyEnumStatus status;
///
///   const InitialState() : status = MyEnumStatus.initial;
/// }
/// ```
abstract class BlocState<Status extends Enum> extends Equatable {
  Status get status;

  const BlocState();

  @override
  List<Object?> get props => [status];

  @override
  String toString() => status.toString();
}
