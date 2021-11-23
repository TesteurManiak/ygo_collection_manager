import 'package:hive_flutter/adapters.dart';

part 'card_images.g.dart';

@HiveType(typeId: 2)
class CardImages {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String imageUrlSmall;

  CardImages({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
  });
}
