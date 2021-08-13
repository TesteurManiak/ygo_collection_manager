class SetModel {
  final String setName;
  final String setCode;
  final int numOfCards;
  final DateTime? tcgDate;

  SetModel({
    required this.setName,
    required this.setCode,
    required this.numOfCards,
    required this.tcgDate,
  });

  factory SetModel.fromJson(Map<String, dynamic> json) => SetModel(
        setName: json['set_name'] as String,
        setCode: json['set_code'] as String,
        numOfCards: json['num_of_cards'] as int,
        tcgDate: json['tcg_date'] != null
            ? DateTime.parse(json['tcg_date'] as String)
            : null,
      );
}
