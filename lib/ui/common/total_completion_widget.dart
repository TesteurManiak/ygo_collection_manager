import 'package:flutter/material.dart';

const _kBottomHeight = 14.0;

class TotalCompletionBottomWidget extends StatelessWidget
    with PreferredSizeWidget {
  final double totalCompletion;

  const TotalCompletionBottomWidget({required this.totalCompletion});

  @override
  Widget build(BuildContext context) => TotalCompletionWidget(totalCompletion);

  @override
  Size get preferredSize => const Size.fromHeight(_kBottomHeight);
}

class TotalCompletionWidget extends StatefulWidget {
  final double totalCompletion;

  const TotalCompletionWidget(this.totalCompletion);

  @override
  State<StatefulWidget> createState() => _TotalCompletionWidgetState();
}

class _TotalCompletionWidgetState extends State<TotalCompletionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: _kBottomHeight,
                child: LinearProgressIndicator(
                  value: widget.totalCompletion / 100,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('${widget.totalCompletion.toStringAsFixed(0)}%'),
        ],
      ),
    );
  }
}
