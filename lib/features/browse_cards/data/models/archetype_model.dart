import 'package:ygo_collection_manager/features/browse_cards/domain/entities/archetype.dart';

class ArchetypeModel extends Archetype {
  ArchetypeModel({required String name}) : super(name: name);

  factory ArchetypeModel.fromJson(Map<String, dynamic> json) =>
      ArchetypeModel(name: json['archetype_name'] as String);
}
