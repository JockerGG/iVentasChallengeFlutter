import 'package:flutter/services.dart';

extension Colors on Color {
  String toHex() => '#${value.toRadixString(16)}';
}
