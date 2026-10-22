import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Responsive units shared by every screen.
///
/// Flutter sizes are density-independent logical pixels, not CSS lengths. To
/// keep the same visual rhythm on different viewports we derive sizes from the
/// current viewport instead of hardcoding them:
///
/// * [rem] is the equivalent of CSS `rem` (based on the smallest side).
/// * [sp] scales a design token with [rem].
/// * [vw] and [vh] are the equivalents of CSS `vw` and `vh`.
///
/// Every helper clamps its result so small phones stay compact and large
/// screens do not become oversized.
class AppLayout {
  AppLayout._();

  static const double _designWidth = 390;
  static const double _minScale = .85;
  static const double _maxScale = 1.3;
  static const double _shortViewport = 700;

  static Size _viewport(BuildContext context) => MediaQuery.sizeOf(context);

  static double _clamp(double value, double min, double max) =>
      value.clamp(min, max).toDouble();

  /// Equivalent of CSS `rem`: one unit relative to the smallest viewport side.
  static double rem(BuildContext context) {
    final viewport = _viewport(context);
    return _clamp(
      math.min(viewport.width, viewport.height) / _designWidth,
      _minScale,
      _maxScale,
    );
  }

  /// Scales a design token with [rem].
  static double sp(
    BuildContext context,
    double value, {
    double min = 0,
    double max = double.infinity,
  }) => _clamp(value * rem(context), min, max);

  /// Equivalent of CSS `vw`: [percent] percent of the viewport width.
  static double vw(
    BuildContext context,
    double percent, {
    double min = 0,
    double max = double.infinity,
  }) => _clamp(_viewport(context).width * percent / 100, min, max);

  /// Equivalent of CSS `vh`: [percent] percent of the viewport height.
  static double vh(
    BuildContext context,
    double percent, {
    double min = 0,
    double max = double.infinity,
  }) => _clamp(_viewport(context).height * percent / 100, min, max);

  /// Fluid vertical gap that follows the available height.
  static double gap(
    BuildContext context,
    double percent, {
    double min = 0,
    double max = double.infinity,
  }) => vh(context, percent, min: min, max: max);

  static bool isShort(BuildContext context) =>
      _viewport(context).height < _shortViewport;

  static double contentWidth(BuildContext context) {
    final size = _viewport(context);
    final largeText = MediaQuery.textScalerOf(context).scale(16) > 22;
    return size.width >= 1000 && !largeText ? 1200 : 720;
  }

  static double gutter(BuildContext context) =>
      vw(context, 4, min: 16, max: 40);

  static bool useColumns(BoxConstraints constraints) =>
      constraints.maxWidth >= 900;

  /// Scales every typography token with the current viewport. The device text
  /// scaling setting is still applied by Flutter afterwards.
  static TextTheme scaleTextTheme(BuildContext context, TextTheme base) {
    TextStyle? scale(TextStyle? style) => style?.copyWith(
          fontSize: style.fontSize == null ? null : sp(context, style.fontSize!),
        );
    return base.copyWith(
      displayLarge: scale(base.displayLarge),
      displayMedium: scale(base.displayMedium),
      displaySmall: scale(base.displaySmall),
      headlineLarge: scale(base.headlineLarge),
      headlineMedium: scale(base.headlineMedium),
      headlineSmall: scale(base.headlineSmall),
      titleLarge: scale(base.titleLarge),
      titleMedium: scale(base.titleMedium),
      titleSmall: scale(base.titleSmall),
      bodyLarge: scale(base.bodyLarge),
      bodyMedium: scale(base.bodyMedium),
      bodySmall: scale(base.bodySmall),
      labelLarge: scale(base.labelLarge),
      labelMedium: scale(base.labelMedium),
      labelSmall: scale(base.labelSmall),
    );
  }
}
