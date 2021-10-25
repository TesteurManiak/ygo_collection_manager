enum Format { tcg, goat, ocgGoat, speedDuel, rushDuel, duelLinks }

extension FormatModifier on Format {
  String get string {
    switch (this) {
      case Format.tcg:
        return 'tcg';
      case Format.goat:
        return 'goat';
      case Format.ocgGoat:
        return 'ocg goat';
      case Format.speedDuel:
        return 'speed duel';
      case Format.rushDuel:
        return 'rush duel';
      case Format.duelLinks:
        return 'duel links';
    }
  }
}
