import '../../core/bloc/bloc.dart';
import '../../domain/repository/ygopro_repository.dart';

class DBVersionBloc implements BlocBase {
  final YgoProRepository repository;

  DBVersionBloc({required this.repository});

  @override
  void initState() {}

  @override
  void dispose() {}

  Future<bool> shouldReloadDatabase() async {
    return repository.shouldReloadDb();
  }

  // Future<void> updateDatabase() async {
  //   await repository.shouldReloadDb();
  //   // await repository.updateDatabase();
  // }
}
