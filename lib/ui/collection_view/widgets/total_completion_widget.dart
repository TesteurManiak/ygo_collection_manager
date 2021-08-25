import 'package:flutter/material.dart';

const _kBottomHeight = 14.0;

class TotalCompletionWidget extends StatefulWidget with PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => _TotalCompletionWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(_kBottomHeight);
}

class _TotalCompletionWidgetState extends State<TotalCompletionWidget> {
  final _value = 25.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text('${_value.toStringAsFixed(0)}%'),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: _kBottomHeight,
                child: LinearProgressIndicator(
                  value: _value / 100,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
