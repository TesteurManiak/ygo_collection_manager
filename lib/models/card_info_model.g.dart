// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_info_model.dart';

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
      views: fields[3] as int?,
      betaName: fields[1] as String?,
      staple: fields[2] as String?,
      viewsWeek: fields[4] as int?,
      upvotes: fields[5] as int?,
      downvotes: fields[6] as int,
      formats: (fields[7] as List).cast<String>(),
      betaId: fields[8] as int?,
      tcgDate: fields[9] as DateTime?,
      ocgDate: fields[10] as DateTime?,
      konamiId: fields[11] as int?,
      hasEffect: fields[12] as int?,
      treatedAs: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardMiscInfo obj) {
    writer
      ..writeByte(13)
      ..writeByte(1)
      ..write(obj.betaName)
      ..writeByte(2)
      ..write(obj.staple)
      ..writeByte(3)
      ..write(obj.views)
      ..writeByte(4)
      ..write(obj.viewsWeek)
      ..writeByte(5)
      ..write(obj.upvotes)
      ..writeByte(6)
      ..write(obj.downvotes)
      ..writeByte(7)
      ..write(obj.formats)
      ..writeByte(8)
      ..write(obj.betaId)
      ..writeByte(9)
      ..write(obj.tcgDate)
      ..writeByte(10)
      ..write(obj.ocgDate)
      ..writeByte(11)
      ..write(obj.konamiId)
      ..writeByte(12)
      ..write(obj.hasEffect)
      ..writeByte(13)
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

class CardPriceModelAdapter extends TypeAdapter<CardPriceModel> {
  @override
  final int typeId = 5;

  @override
  CardPriceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardPriceModel(
      cardmarket: fields[0] as String,
      tcgplayer: fields[1] as String,
      ebay: fields[2] as String,
      amazon: fields[3] as String,
      coolstuffinc: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardPriceModel obj) {
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
      other is CardPriceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardModelSetAdapter extends TypeAdapter<CardModelSet> {
  @override
  final int typeId = 4;

  @override
  CardModelSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardModelSet(
      name: fields[0] as String,
      code: fields[1] as String,
      rarity: fields[2] as String,
      rarityCode: fields[3] as String,
      price: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardModelSet obj) {
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
      other is CardModelSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      linkmarkers: (fields[13] as List?)?.cast<String>(),
      cardImages: (fields[12] as List).cast<CardImages>(),
      cardSets: (fields[14] as List?)?.cast<CardModelSet>(),
      cardPrices: (fields[15] as List).cast<CardPriceModel>(),
      banlistInfo: fields[16] as CardBanlistInfo?,
      miscInfo: (fields[17] as List).cast<CardMiscInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, CardInfoModel obj) {
    writer
      ..writeByte(18)
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
      ..write(obj.cardImages)
      ..writeByte(13)
      ..write(obj.linkmarkers)
      ..writeByte(14)
      ..write(obj.cardSets)
      ..writeByte(15)
      ..write(obj.cardPrices)
      ..writeByte(16)
      ..write(obj.banlistInfo)
      ..writeByte(17)
      ..write(obj.miscInfo);
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
