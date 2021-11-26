import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'card_images.g.dart';

@HiveType(typeId: 2)
class CardImages extends Equatable {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String imageUrlSmall;

  const CardImages({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
  });

  @override
  List<Object?> get props => [id, imageUrl, imageUrlSmall];
}
