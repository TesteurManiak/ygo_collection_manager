import 'package:flutter/material.dart';

class AddRemoveCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: const [
          _EditionLine(label: '1st Edition'),
          _EditionLine(label: 'Unlimited'),
        ],
      ),
    );
  }
}

class _EditionLine extends StatefulWidget {
  final String label;
  final int initialQuantity;

  const _EditionLine({required this.label, this.initialQuantity = 0});

  @override
  State<StatefulWidget> createState() => _EditionLineState();
}

class _EditionLineState extends State<_EditionLine> {
  late int _quantity = widget.initialQuantity;

  void _addCard() => setState(() => _quantity++);

  void _removeCard() => setState(() => _quantity--);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label),
        Expanded(child: Container()),
        IconButton(onPressed: _removeCard, icon: const Icon(Icons.remove)),
        Text('$_quantity'),
        IconButton(onPressed: _addCard, icon: const Icon(Icons.add)),
      ],
    );
  }
}
