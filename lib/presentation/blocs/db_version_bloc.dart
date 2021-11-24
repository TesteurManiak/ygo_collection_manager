import '../../core/bloc/bloc.dart';
import '../../domain/usecases/should_reload_db.dart';

class DBVersionBloc implements BlocBase {
  final ShouldReloadDb shouldReloadDb;

  DBVersionBloc({required this.shouldReloadDb});

  @override
  void initState() {}

  @override
  void dispose() {}

  Future<bool> shouldReloadDatabase() => shouldReloadDb();

  // Future<void> updateDatabase() async {
  //   await repository.shouldReloadDb();
  //   // await repository.updateDatabase();
  // }
}
