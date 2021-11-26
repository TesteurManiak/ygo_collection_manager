import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'card_misc_info.g.dart';

@HiveType(typeId: 7)
class CardMiscInfo extends Equatable {
  @HiveField(0)
  final String? betaName;

  @HiveField(1)
  final String? staple;

  @HiveField(2)
  final int? views;

  @HiveField(3)
  final int? viewsWeek;

  @HiveField(4)
  final int? upvotes;

  @HiveField(5)
  final int downvotes;

  @HiveField(6)
  final List<String> formats;

  @HiveField(7)
  final int? betaId;

  @HiveField(8)
  final DateTime? tcgDate;

  @HiveField(9)
  final DateTime? ocgDate;

  @HiveField(10)
  final int? konamiId;

  @HiveField(11)
  final int? hasEffect;

  @HiveField(12)
  final String? treatedAs;

  const CardMiscInfo({
    required this.views,
    required this.betaName,
    required this.staple,
    required this.viewsWeek,
    required this.upvotes,
    required this.downvotes,
    required this.formats,
    required this.betaId,
    required this.tcgDate,
    required this.ocgDate,
    required this.konamiId,
    required this.hasEffect,
    required this.treatedAs,
  });

  @override
  List<Object?> get props => [
        betaName,
        staple,
        views,
        viewsWeek,
        upvotes,
        downvotes,
        formats,
        betaId,
        tcgDate,
        ocgDate,
        konamiId,
        hasEffect,
        treatedAs,
      ];
}
