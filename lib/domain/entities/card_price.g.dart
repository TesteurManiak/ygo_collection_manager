// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_price.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardPriceAdapter extends TypeAdapter<CardPrice> {
  @override
  final int typeId = 5;

  @override
  CardPrice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardPrice(
      cardmarket: fields[0] as String,
      tcgplayer: fields[1] as String,
      ebay: fields[2] as String,
      amazon: fields[3] as String,
      coolstuffinc: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardPrice obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardmarket)
      ..writeByte(1)
      ..write(obj.tcgplayer)
      ..writeByte(2)
      ..write(obj.ebay)
      ..writeByte(3)
      ..write(obj.amazon)
      ..writeByte(4)
      ..write(obj.coolstuffinc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardPriceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
