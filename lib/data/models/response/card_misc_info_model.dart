import '../../../../domain/entities/card_misc_info.dart';

class CardMiscInfoModel extends CardMiscInfo {
  CardMiscInfoModel({
    required int? views,
    required String? betaName,
    required String? staple,
    required int? viewsWeek,
    required int? upvotes,
    required int downvotes,
    required List<String> formats,
    required int? betaId,
    required DateTime? tcgDate,
    required DateTime? ocgDate,
    required int? konamiId,
    required int? hasEffect,
    required String? treatedAs,
  }) : super(
          views: views,
          betaName: betaName,
          staple: staple,
          viewsWeek: viewsWeek,
          upvotes: upvotes,
          downvotes: downvotes,
          formats: formats,
          betaId: betaId,
          tcgDate: tcgDate,
          ocgDate: ocgDate,
          konamiId: konamiId,
          hasEffect: hasEffect,
          treatedAs: treatedAs,
        );

  factory CardMiscInfoModel.fromJson(Map<String, dynamic> json) {
    return CardMiscInfoModel(
      views: json['views'] as int?,
      betaName: json['beta_name'] as String?,
      staple: json['staple'] as String?,
      viewsWeek: json['views_week'] as int?,
      upvotes: json['upvotes'] as int?,
      downvotes: json['downvotes'] as int,
      formats: List<String>.from(json['formats'] as Iterable),
      betaId: json['beta_id'] as int?,
      tcgDate: json['tcg_date'] != null
          ? DateTime.tryParse(json['tcg_date'] as String)
          : null,
      ocgDate: json['ocg_date'] != null
          ? DateTime.tryParse(json['ocg_date'] as String)
          : null,
      konamiId: json['konami_id'] as int?,
      hasEffect: json['has_effect'] as int?,
      treatedAs: json['treated_as'] as String?,
    );
  }
}
