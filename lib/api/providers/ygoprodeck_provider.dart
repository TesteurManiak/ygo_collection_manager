import 'package:dio/dio.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class YgoProDeckProvider {
  static final baseUrl = Uri(scheme: 'https', host: 'db.ygoprodeck.com');
  static const basePath = <String>['api', 'v7'];
  static const cardInfoPath = 'cardinfo.php';
  static const randomCardPath = 'randomcard.php';
  static const setsPath = 'cardsets.php';
  static const cardSetsInfoPath = 'cardsetsinfo.php';
  static const archetypesPath = 'archetypes.php';
  static const checkDBVerPath = 'checkDBVer.php';

  final Dio _dio;

  YgoProDeckProvider(this._dio);

  Future<List<CardInfoModel>> getCardInfo({
    List<String>? names,
    String? fname,
    List<int>? ids,
    List<String>? types,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (names != null) queryParameters['name'] = names.join('|');
    if (fname != null) queryParameters['fname'] = fname;
    if (ids != null) queryParameters['id'] = ids.join(',');
    if (types != null) queryParameters['type'] = types.join(',');

    final data = await getCall<Map<String, dynamic>>(
      [cardInfoPath],
      queryParameters: queryParameters,
    );
    return (data['data'] as Iterable)
        .map<CardInfoModel>(
            (e) => CardInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<SetModel>> getSets() async {
    final data = await getCall<Iterable>([setsPath]);
    return data
        .map<SetModel>((e) => SetModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<T> getCall<T>(
    Iterable<String> pathSegments, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    final response = await _dio.getUri(
      baseUrl.replace(
        pathSegments: <String>[...basePath, ...pathSegments],
        queryParameters: queryParameters,
      ),
    );
    return response.data as T;
  }
}
