import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final bool numericKeyboard;
  final Function() onSubmitted;
  final TextEditingController dataController;
  final String label;

  const AdaptativeTextField(
      {super.key,
      required this.onSubmitted,
      required this.label,
      required this.dataController,
      this.numericKeyboard = false});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            keyboardType: numericKeyboard
                ? const TextInputType.numberWithOptions(decimal: true)
                : null,
                onSubmitted: (_) => onSubmitted(),
                controller: dataController,
                placeholder: label,
          )
        : TextField(
            keyboardType: numericKeyboard
                ? const TextInputType.numberWithOptions(
                    decimal: true,
                  )
                : null,
            onSubmitted: (_) => onSubmitted(),
            controller: dataController,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
