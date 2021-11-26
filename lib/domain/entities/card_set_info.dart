import 'package:equatable/equatable.dart';

class CardSetInfo extends Equatable {
  final int id;
  final String name;
  final String setName;
  final String setCode;
  final String setRarity;
  final String setPrice;

  const CardSetInfo({
    required this.id,
    required this.name,
    required this.setName,
    required this.setCode,
    required this.setRarity,
    required this.setPrice,
  });

  @override
  List<Object?> get props => [id, name, setName, setCode, setRarity, setPrice];
}
