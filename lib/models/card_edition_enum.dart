import 'package:hive/hive.dart';

part 'card_edition_enum.g.dart';

@HiveType(typeId: 9)
enum CardEditionEnum {
  @HiveField(1)
  first,

  @HiveField(2)
  unlimited,
}

extension CardEditionEnumModifier on CardEditionEnum {
  String get string {
    switch (this) {
      case CardEditionEnum.first:
        return '1st Edition';
      case CardEditionEnum.unlimited:
        return 'Unlimited';
    }
  }
}
