import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'card_banlist_info.g.dart';

@HiveType(typeId: 6)
class CardBanlistInfo extends Equatable {
  @HiveField(0)
  final String? tcg;

  @HiveField(1)
  final String? ocg;

  @HiveField(2)
  final String? goat;

  const CardBanlistInfo({
    required this.tcg,
    required this.ocg,
    required this.goat,
  });

  @override
  List<Object?> get props => [tcg, ocg, goat];
}
