// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetModelAdapter extends TypeAdapter<SetModel> {
  @override
  final int typeId = 3;

  @override
  SetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SetModel(
      setName: fields[0] as String,
      setCode: fields[1] as String,
      numOfCards: fields[2] as int,
      tcgDate: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SetModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.setName)
      ..writeByte(1)
      ..write(obj.setCode)
      ..writeByte(2)
      ..write(obj.numOfCards)
      ..writeByte(3)
      ..write(obj.tcgDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
