import 'package:hive_flutter/adapters.dart';

part 'card_price.g.dart';

@HiveType(typeId: 5)
class CardPrice {
  @HiveField(0)
  final String cardmarket;

  @HiveField(1)
  final String tcgplayer;

  @HiveField(2)
  final String ebay;

  @HiveField(3)
  final String amazon;

  @HiveField(4)
  final String coolstuffinc;

  CardPrice({
    required this.cardmarket,
    required this.tcgplayer,
    required this.ebay,
    required this.amazon,
    required this.coolstuffinc,
  });
}
