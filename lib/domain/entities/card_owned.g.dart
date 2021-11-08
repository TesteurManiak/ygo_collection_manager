// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_owned.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardOwnedAdapter extends TypeAdapter<CardOwned> {
  @override
  final int typeId = 8;

  @override
  CardOwned read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardOwned(
      quantity: fields[1] as int,
      setCode: fields[2] as String,
      edition: fields[3] as CardEditionEnum,
      setName: fields[4] as String,
      id: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CardOwned obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.setCode)
      ..writeByte(3)
      ..write(obj.edition)
      ..writeByte(4)
      ..write(obj.setName)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardOwnedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
