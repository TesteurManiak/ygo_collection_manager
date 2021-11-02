// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_edition_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardEditionEnumAdapter extends TypeAdapter<CardEditionEnum> {
  @override
  final int typeId = 9;

  @override
  CardEditionEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return CardEditionEnum.first;
      case 2:
        return CardEditionEnum.unlimited;
      default:
        return CardEditionEnum.first;
    }
  }

  @override
  void write(BinaryWriter writer, CardEditionEnum obj) {
    switch (obj) {
      case CardEditionEnum.first:
        writer.writeByte(1);
        break;
      case CardEditionEnum.unlimited:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardEditionEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
