// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_info_model.dart';

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
      id: fields[0] as int,
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

class CardInfoModelAdapter extends TypeAdapter<CardInfoModel> {
  @override
  final int typeId = 1;

  @override
  CardInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardInfoModel(
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
    );
  }

  @override
  void write(BinaryWriter writer, CardInfoModel obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.cardImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
