import '../../core/bloc/bloc.dart';
import '../../domain/repository/ygopro_repository.dart';
import '../../service_locator.dart';

class DBVersionBloc extends BlocBase {
  @override
  void initState() {}

  @override
  void dispose() {}

  Future<bool> shouldReloadDatabase() async {
    final repo = sl<YgoProRepository>();
    return repo.shouldReloadDb();
  }
}
