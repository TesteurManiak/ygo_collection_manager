import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';

const _kBottomHeight = 14.0;

class TotalCompletionBottomWidget extends StatelessWidget
    with PreferredSizeWidget {
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  borderRadius: BorderRadius.circular(20),
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
              const SizedBox(width: 8),
              Text('${completion.toStringAsFixed(0)}%'),
            ],
          );
        },
      ),
    );
  }
}
