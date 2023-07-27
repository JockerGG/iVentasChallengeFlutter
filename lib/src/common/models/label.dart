import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/utils/color_extensions.dart';
import 'package:iventas_challenge/src/utils/string_extensions.dart';

final class Label {
  final String label;
  final Color labelColor;

  const Label(this.label, this.labelColor);

  factory Label.fromJson(json) {
    final String hexColor = json['labelColor'];
    return Label(json['label'], hexColor.toColor());
  }

  Map<String, dynamic> toJson() =>
      {"label": label, "labelColor": labelColor.toHex()};
}
