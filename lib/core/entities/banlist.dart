enum Banlist { tcg, ocg, goat }

extension BanlistModifier on Banlist {
  String get string {
    switch (this) {
      case Banlist.tcg:
        return 'TCG';
      case Banlist.ocg:
        return 'OCG';
      case Banlist.goat:
        return 'GOAT';
    }
  }
}
