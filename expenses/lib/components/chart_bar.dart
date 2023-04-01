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
    return LayoutBuilder(
      builder: (cxt, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  value.toStringAsFixed(2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: constraints.maxHeight * 0.05,
                bottom: constraints.maxHeight * 0.05,
              ),
              child: SizedBox(
                height: constraints.maxHeight * 0.7,
                width: 10,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentege,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  label,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
