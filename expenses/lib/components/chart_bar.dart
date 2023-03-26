import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentege;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentege,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'R\$${value.toStringAsFixed(2)}',
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
          child: SizedBox(
            height: 60,
            width: 10,
            child: null,
          ),
        ),
        Text(
          label,
        ),
      ],
    );
  }
}
