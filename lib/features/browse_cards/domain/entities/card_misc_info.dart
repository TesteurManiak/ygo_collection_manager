class CardMiscInfo {
  final String? betaName;
  final String? staple;
  final int? views;
  final int? viewsWeek;
  final int? upvotes;
  final int downvotes;
  final List<String> formats;
  final int? betaId;
  final DateTime? tcgDate;
  final DateTime? ocgDate;
  final int? konamiId;
  final int? hasEffect;
  final String? treatedAs;

  CardMiscInfo({
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
}
