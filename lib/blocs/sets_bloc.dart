import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class SetsBloc extends BlocBase {
  final _setsController = BehaviorSubject<List<SetModel>?>.seeded(null);
  Stream<List<SetModel>?> get onSetsChanged => _setsController.stream;

  @override
  void dispose() {
    _setsController.close();
  }

  @override
  void initState() {}

  Future<void> fetchAllSets() async {
    try {
      final data = await apiRepository.getAllSets();
      _setsController.sink.add(data);
    } catch (e) {
      _setsController.addError(e);
    }
  }

  Future<void> refreshSets() => fetchAllSets();
}
