import '../../domain/entities/card_images.dart';

class CardImagesModel extends CardImages {
  CardImagesModel({
    required int id,
    required String imageUrl,
    required String imageUrlSmall,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          imageUrlSmall: imageUrlSmall,
        );

  factory CardImagesModel.fromJson(Map<String, dynamic> json) {
    return CardImagesModel(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String,
      imageUrlSmall: json['image_url_small'] as String,
    );
  }
}
