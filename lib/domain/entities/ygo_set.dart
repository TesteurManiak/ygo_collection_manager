import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'ygo_set.g.dart';

@HiveType(typeId: 3)
class YgoSet extends Equatable {
  @HiveField(0)
  final String setName;

  @HiveField(1)
  final String setCode;

  @HiveField(2)
  final int numOfCards;

  @HiveField(3)
  final DateTime? tcgDate;

  const YgoSet({
    required this.setName,
    required this.setCode,
    required this.numOfCards,
    required this.tcgDate,
  });

  @override
  List<Object?> get props => [setName, setCode, numOfCards, tcgDate];
}
