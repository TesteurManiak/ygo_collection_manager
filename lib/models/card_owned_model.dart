import 'package:hive/hive.dart';
import 'package:ygo_collection_manager/models/card_edition_enum.dart';

class CardOwnedModel {
  /// Id of the [CardInfoModel] in the database.
  @HiveField(1)
  final int cardId;

  /// Quantity of cards owned.
  @HiveField(2)
  final int quantity;

  /// Code of the card in the set, ex: DB1-EN109.
  @HiveField(3)
  final String code;

  /// Rarity of the card.
  @HiveField(4)
  final String rarity;

  /// If the card is 1st edition or unlimited.
  @HiveField(5)
  final CardEditionEnum edition;

  /// Key of the card in the database.
  String get key => '$code-$rarity-$edition';

  CardOwnedModel({
    required this.cardId,
    required this.quantity,
    required this.code,
    required this.rarity,
    required this.edition,
  });
}
