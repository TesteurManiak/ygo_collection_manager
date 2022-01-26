import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../blocs/cards/cards_bloc.dart';

const _kBottomHeight = Consts.px14;

class TotalCompletionBottomWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const TotalCompletionBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TotalCompletionWidget();

  @override
  Size get preferredSize => const Size.fromHeight(_kBottomHeight);
}

class TotalCompletionWidget extends StatelessWidget {
  final double Function()? getTotalCompletion;

  const TotalCompletionWidget({Key? key, this.getTotalCompletion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cardsBloc = BlocProvider.of<CardsBloc>(context);
    return Padding(
      padding: MyEdgeInsets.symH16,
      child: StreamBuilder<double>(
        stream: _cardsBloc.onFullCollectionCompletionChanged,
        initialData: _cardsBloc.fullCollectionCompletion,
        builder: (context, snapshot) {
          final completion = getTotalCompletion != null
              ? getTotalCompletion!()
              : snapshot.data!;
          return Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Consts.px20),
                  child: SizedBox(
                    height: _kBottomHeight,
                    child: LinearProgressIndicator(
                      value: completion / 100,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Consts.px8),
              Text('${completion.toStringAsFixed(0)}%'),
            ],
          );
        },
      ),
    );
  }
}
