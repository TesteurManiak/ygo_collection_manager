// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ygo_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YgoCardAdapter extends TypeAdapter<YgoCard> {
  @override
  final int typeId = 1;

  @override
  YgoCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YgoCard(
      id: fields[0] as int,
      name: fields[1] as String,
      type: fields[2] as String,
      desc: fields[3] as String,
      atk: fields[4] as int?,
      def: fields[5] as int?,
      level: fields[6] as int?,
      race: fields[7] as String,
      attribute: fields[8] as String?,
      archetype: fields[9] as String?,
      scale: fields[10] as int?,
      linkval: fields[11] as int?,
      cardImages: (fields[12] as List).cast<CardImages>(),
      linkmarkers: (fields[13] as List?)?.cast<String>(),
      cardSets: (fields[14] as List?)?.cast<CardSet>(),
      cardPrices: (fields[15] as List).cast<CardPrice>(),
      banlistInfo: fields[16] as CardBanlistInfo?,
      miscInfo: (fields[17] as List?)?.cast<CardMiscInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, YgoCard obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.atk)
      ..writeByte(5)
      ..write(obj.def)
      ..writeByte(6)
      ..write(obj.level)
      ..writeByte(7)
      ..write(obj.race)
      ..writeByte(8)
      ..write(obj.attribute)
      ..writeByte(9)
      ..write(obj.archetype)
      ..writeByte(10)
      ..write(obj.scale)
      ..writeByte(11)
      ..write(obj.linkval)
      ..writeByte(12)
      ..write(obj.cardImages)
      ..writeByte(13)
      ..write(obj.linkmarkers)
      ..writeByte(14)
      ..write(obj.cardSets)
      ..writeByte(15)
      ..write(obj.cardPrices)
      ..writeByte(16)
      ..write(obj.banlistInfo)
      ..writeByte(17)
      ..write(obj.miscInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YgoCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
