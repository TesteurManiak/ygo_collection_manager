import '../core/bloc/bloc.dart';
import '../data/datasources/local/ygopro_local_datasource.dart';
import '../data/datasources/remote/ygopro_remote_data_source.dart';
import '../service_locator.dart';

class DBVersionBloc extends BlocBase {
  @override
  void initState() {}

  @override
  void dispose() {}

  Future<bool> shouldReloadDatabase() async {
    final remoteRepo = locator<YgoProRemoteDataSource>();
    final localRepo = locator<YgoProLocalDataSource>();
    final savedDbVersion = await localRepo.getDatabaseVersion();
    final fetchedDbVersion = await remoteRepo.checkDatabaseVersion();

    final shouldReload = savedDbVersion == null ||
        savedDbVersion.version != fetchedDbVersion.version;
    localRepo.updateDbVersion(fetchedDbVersion);
    return shouldReload;
  }
}
