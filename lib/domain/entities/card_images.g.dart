// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardImagesAdapter extends TypeAdapter<CardImages> {
  @override
  final int typeId = 2;

  @override
  CardImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardImages(
      id: fields[0] as int?,
      imageUrl: fields[1] as String,
      imageUrlSmall: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardImages obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.imageUrlSmall);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
