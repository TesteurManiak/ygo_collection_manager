import '../../domain/entities/ygo_card.dart';

class YgoCardModel extends YgoCard {
  YgoCardModel({
    required int id,
    required String name,
    required String type,
    required String desc,
    required int? atk,
    required int? def,
    required int? level,
    required String race,
    required String? attribute,
    required String? archetype,
    required int? scale,
    required int? linkval,
    required List<String>? linkmarkers,
  }) : super(
          id: id,
          name: name,
          type: type,
          desc: desc,
          atk: atk,
          def: def,
          level: level,
          race: race,
          attribute: attribute,
          archetype: archetype,
          scale: scale,
          linkval: linkval,
          linkmarkers: linkmarkers,
        );
}
