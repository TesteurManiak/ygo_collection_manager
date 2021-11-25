import '../../../../domain/entities/ygo_set.dart';

class YgoSetModel extends YgoSet {
  const YgoSetModel({
    required String setName,
    required String setCode,
    required int numOfCards,
    required DateTime? tcgDate,
  }) : super(
          setName: setName,
          setCode: setCode,
          numOfCards: numOfCards,
          tcgDate: tcgDate,
        );

  factory YgoSetModel.fromJson(Map<String, dynamic> json) => YgoSetModel(
        setName: json['set_name'] as String,
        setCode: json['set_code'] as String,
        numOfCards: json['num_of_cards'] as int,
        tcgDate: json['tcg_date'] == null
            ? null
            : DateTime.parse(json['tcg_date'] as String),
      );
}
