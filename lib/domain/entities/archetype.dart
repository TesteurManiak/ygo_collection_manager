import 'package:equatable/equatable.dart';

class Archetype extends Equatable {
  final String name;

  const Archetype({required this.name});

  @override
  List<Object?> get props => [name];
}
