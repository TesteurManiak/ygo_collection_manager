import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import 'card_edition_enum.dart';

part 'card_owned.g.dart';

@HiveType(typeId: 8)
class CardOwned extends Equatable {
  /// Quantity of cards owned.
  @HiveField(1)
  final int quantity;

  /// Code of the card in the set, ex: DB1-EN109.
  @HiveField(2)
  final String setCode;

  /// If the card is 1st edition or unlimited.
  @HiveField(3)
  final CardEditionEnum edition;

  @HiveField(4)
  final String setName;

  @HiveField(5)
  final int id;

  String get key => '$setCode-${edition.string}';

  const CardOwned({
    required this.quantity,
    required this.setCode,
    required this.edition,
    required this.setName,
    required this.id,
  });

  @override
  List<Object?> get props => [
        quantity,
        setCode,
        edition,
        setName,
        id,
      ];
}
