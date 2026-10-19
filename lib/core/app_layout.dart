import 'package:flutter/material.dart';

/// Shared content limits keep reading and controls comfortable on large screens.
class AppLayout {
  static double contentWidth(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final largeText = MediaQuery.textScalerOf(context).scale(16) > 22;
    return size.width >= 1000 && !largeText ? 1200 : 720;
  }

  static double gutter(BuildContext context) =>
      (MediaQuery.sizeOf(context).width * .04).clamp(16.0, 40.0);

  static bool useColumns(BoxConstraints constraints) =>
      constraints.maxWidth >= 900;
}
