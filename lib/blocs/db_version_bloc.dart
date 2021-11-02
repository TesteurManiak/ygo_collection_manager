import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/core/bloc/bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';

class DBVersionBloc extends BlocBase {
  @override
  void initState() {}

  @override
  void dispose() {}

  Future<bool> shouldReloadDatabase() async {
    final savedDbVersion = HiveHelper.instance.databaseVersion;
    final fetchedDbVersion = await apiRepository.checkDatabaseVersion();

    final shouldReload = savedDbVersion == null ||
        savedDbVersion.version != fetchedDbVersion.version;
    HiveHelper.instance.updateDatabaseVersion(fetchedDbVersion);
    return shouldReload;
  }
}
