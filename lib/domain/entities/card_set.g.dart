// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardSetAdapter extends TypeAdapter<CardSet> {
  @override
  final int typeId = 4;

  @override
  CardSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardSet(
      name: fields[0] as String,
      code: fields[1] as String,
      rarity: fields[2] as String,
      rarityCode: fields[3] as String?,
      price: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardSet obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.rarity)
      ..writeByte(3)
      ..write(obj.rarityCode)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
