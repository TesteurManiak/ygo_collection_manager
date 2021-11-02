import 'package:hive_flutter/adapters.dart';

part 'card_banlist_info.g.dart';

@HiveType(typeId: 6)
class CardBanlistInfo {
  @HiveField(0)
  final String? tcg;

  @HiveField(1)
  final String? ocg;

  @HiveField(2)
  final String? goat;

  CardBanlistInfo({
    required this.tcg,
    required this.ocg,
    required this.goat,
  });
}
