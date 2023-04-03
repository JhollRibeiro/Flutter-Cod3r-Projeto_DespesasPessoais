import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final Function(String) onSubmitted;
  final TextEditingController dataController;
  final String label;

  const AdaptativeTextField(
      {super.key,
      required this.onSubmitted,
      required this.label,
      required this.dataController,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            keyboardType: keyboardType,
                onSubmitted: onSubmitted,
                controller: dataController,
                placeholder: label,
          )
        : TextField(
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            controller: dataController,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
