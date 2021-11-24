// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_banlist_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardBanlistInfoAdapter extends TypeAdapter<CardBanlistInfo> {
  @override
  final int typeId = 6;

  @override
  CardBanlistInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardBanlistInfo(
      tcg: fields[0] as String?,
      ocg: fields[1] as String?,
      goat: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardBanlistInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tcg)
      ..writeByte(1)
      ..write(obj.ocg)
      ..writeByte(2)
      ..write(obj.goat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardBanlistInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
