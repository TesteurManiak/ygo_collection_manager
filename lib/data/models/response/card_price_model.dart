import '../../../../domain/entities/card_price.dart';

class CardPriceModel extends CardPrice {
  CardPriceModel({
    required String cardmarket,
    required String tcgplayer,
    required String ebay,
    required String amazon,
    required String coolstuffinc,
  }) : super(
          cardmarket: cardmarket,
          tcgplayer: tcgplayer,
          ebay: ebay,
          amazon: amazon,
          coolstuffinc: coolstuffinc,
        );

  factory CardPriceModel.fromJson(Map<String, dynamic> json) {
    return CardPriceModel(
      cardmarket: json['cardmarket_price'] as String,
      tcgplayer: json['tcgplayer_price'] as String,
      ebay: json['ebay_price'] as String,
      amazon: json['amazon_price'] as String,
      coolstuffinc: json['coolstuffinc_price'] as String,
    );
  }
}
