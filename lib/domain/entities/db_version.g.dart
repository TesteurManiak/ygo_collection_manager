// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_version.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbVersionAdapter extends TypeAdapter<DbVersion> {
  @override
  final int typeId = 0;

  @override
  DbVersion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DbVersion(
      lastUpdate: fields[0] as DateTime,
      version: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DbVersion obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lastUpdate)
      ..writeByte(1)
      ..write(obj.version);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbVersionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
