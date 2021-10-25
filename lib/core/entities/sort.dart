enum Sort { atk, def, name, type, level, id, newest }

extension SortModifier on Sort {
  String get string {
    switch (this) {
      case Sort.atk:
        return 'atk';
      case Sort.def:
        return 'def';
      case Sort.name:
        return 'name';
      case Sort.type:
        return 'type';
      case Sort.level:
        return 'level';
      case Sort.id:
        return 'id';
      case Sort.newest:
        return 'new';
    }
  }
}
