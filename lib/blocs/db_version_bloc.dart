import '../core/bloc/bloc.dart';
import '../data/api/ygopro_remote_data_source.dart';
import '../helper/hive_helper.dart';
import '../service_locator.dart';

class DBVersionBloc extends BlocBase {
  @override
  void initState() {}

  @override
  void dispose() {}

  Future<bool> shouldReloadDatabase() async {
    final remoteRepo = locator<YgoProRemoteDataSource>();
    final savedDbVersion = HiveHelper.instance.databaseVersion;
    final fetchedDbVersion = await remoteRepo.checkDatabaseVersion();

    final shouldReload = savedDbVersion == null ||
        savedDbVersion.version != fetchedDbVersion.version;
    HiveHelper.instance.updateDatabaseVersion(fetchedDbVersion);
    return shouldReload;
  }
}
