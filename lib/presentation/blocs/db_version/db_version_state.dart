part of 'db_version_bloc.dart';

enum DbVersionStatus { initial }

abstract class DbVersionState extends BlocState<DbVersionStatus> {
  const DbVersionState();
}

class DbVersionInitial extends DbVersionState {
  @override
  final DbVersionStatus status;

  const DbVersionInitial() : status = DbVersionStatus.initial;
}
