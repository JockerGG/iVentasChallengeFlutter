import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/models/label.dart';

final class IVLabelWidget extends StatelessWidget {
  final Label label;

  const IVLabelWidget(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: label.labelColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
          child: Text(
            label.label,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
