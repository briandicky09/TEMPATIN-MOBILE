import 'package:flutter/widgets.dart';

/// 4dp spacing scale and border-radius tokens matching DESIGN_SYSTEM.md.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
}

abstract final class AppRadii {
  static const double small = 4;
  static const double button = 8;
  static const double input = 8;
  static const double card = 12;
  static const double sheet = 16;
  static const double pill = 9999;

  static final BorderRadius smallRadius = BorderRadius.circular(small);
  static final BorderRadius buttonRadius = BorderRadius.circular(button);
  static final BorderRadius inputRadius = BorderRadius.circular(input);
  static final BorderRadius cardRadius = BorderRadius.circular(card);
  static final BorderRadius pillRadius = BorderRadius.circular(pill);
}
