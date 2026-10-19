import 'package:flutter/material.dart';

class AppMotion {
  static Duration duration(BuildContext context, {int milliseconds = 180}) =>
      MediaQuery.disableAnimationsOf(context)
      ? Duration.zero
      : Duration(milliseconds: milliseconds);
}
