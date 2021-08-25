import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';

class ExpansionCollectionBloc extends BlocBase {
  final _editionStateController = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get onEditionStateChanged => _editionStateController.stream;
  bool get isEditing => _editionStateController.value;

  @override
  void initState() {}

  @override
  void dispose() {
    _editionStateController.close();
  }

  void switchMode() {
    _editionStateController.sink.add(!_editionStateController.value);
    print('Switch to: ${isEditing ? "Edition" : "Collection"}');
  }
}
