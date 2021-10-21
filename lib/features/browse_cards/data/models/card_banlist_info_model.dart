import '../../domain/entities/card_banlist_info.dart';

class CardBanlistInfoModel extends CardBanlistInfo {
  CardBanlistInfoModel({
    required String? tcg,
    required String? ocg,
    required String? goat,
  }) : super(
          tcg: tcg,
          ocg: ocg,
          goat: goat,
        );

  factory CardBanlistInfoModel.fromJson(Map<String, dynamic> json) {
    return CardBanlistInfoModel(
      tcg: json['ban_tcg'] as String?,
      ocg: json['ban_ocg'] as String?,
      goat: json['ban_goat'] as String?,
    );
  }
}
