import 'package:flutter/services.dart';

extension IVColors on Color {
  String toHex() => '#${value.toRadixString(16)}';
}
