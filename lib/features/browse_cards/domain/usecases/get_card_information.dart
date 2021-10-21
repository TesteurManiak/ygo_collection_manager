import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_card.dart';
import '../repositories/ygopro_repository.dart';

class GetCardInformation implements UseCase<List<YgoCard>, GetCardInfoParams> {
  final YgoProRepository repository;

  GetCardInformation(this.repository);

  @override
  Future<Either<Failure, List<YgoCard>>> call(GetCardInfoParams params) =>
      repository.getCardInfo(
        names: params.names,
        fname: params.fname,
        ids: params.ids,
        types: params.types,
        atk: params.atk,
        def: params.def,
        level: params.level,
        races: params.races,
        attributes: params.attributes,
        link: params.link,
        misc: params.misc,
      );
}

class GetCardInfoParams {
  final List<String>? names;
  final String? fname;
  final List<int>? ids;
  final List<String>? types;
  final int? atk;
  final int? def;
  final int? level;
  final List<String>? races;
  final List<String>? attributes;
  final int? link;
  final bool misc;

  GetCardInfoParams({
    this.names,
    this.fname,
    this.ids,
    this.types,
    this.atk,
    this.def,
    this.level,
    this.races,
    this.attributes,
    this.link,
    this.misc = false,
  });
}
