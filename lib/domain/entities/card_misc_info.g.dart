// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_misc_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardMiscInfoAdapter extends TypeAdapter<CardMiscInfo> {
  @override
  final int typeId = 7;

  @override
  CardMiscInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardMiscInfo(
      views: fields[2] as int?,
      betaName: fields[0] as String?,
      staple: fields[1] as String?,
      viewsWeek: fields[3] as int?,
      upvotes: fields[4] as int?,
      downvotes: fields[5] as int,
      formats: (fields[6] as List).cast<String>(),
      betaId: fields[7] as int?,
      tcgDate: fields[8] as DateTime?,
      ocgDate: fields[9] as DateTime?,
      konamiId: fields[10] as int?,
      hasEffect: fields[11] as int?,
      treatedAs: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardMiscInfo obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.betaName)
      ..writeByte(1)
      ..write(obj.staple)
      ..writeByte(2)
      ..write(obj.views)
      ..writeByte(3)
      ..write(obj.viewsWeek)
      ..writeByte(4)
      ..write(obj.upvotes)
      ..writeByte(5)
      ..write(obj.downvotes)
      ..writeByte(6)
      ..write(obj.formats)
      ..writeByte(7)
      ..write(obj.betaId)
      ..writeByte(8)
      ..write(obj.tcgDate)
      ..writeByte(9)
      ..write(obj.ocgDate)
      ..writeByte(10)
      ..write(obj.konamiId)
      ..writeByte(11)
      ..write(obj.hasEffect)
      ..writeByte(12)
      ..write(obj.treatedAs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardMiscInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
