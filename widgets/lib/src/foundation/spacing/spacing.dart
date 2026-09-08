import 'package:flutter/widgets.dart';

/// Mechanix spacing tokens and layout scale primitives.
abstract final class MechanixSpacing {
  /// 2.0 dp
  static const double xxxSmall = 2.0;

  /// 4.0 dp
  static const double xxSmall = 4.0;

  /// 8.0 dp
  static const double xSmall = 8.0;

  /// 12.0 dp
  static const double small = 12.0;

  /// 16.0 dp
  static const double medium = 16.0;

  /// 20.0 dp
  static const double large = 20.0;

  /// 24.0 dp
  static const double xLarge = 24.0;

  /// 32.0 dp
  static const double xxLarge = 32.0;

  /// 40.0 dp
  static const double xxxLarge = 40.0;

  /// 48.0 dp
  static const double huge = 48.0;

  /// 64.0 dp
  static const double massive = 64.0;

  // ---------------------------------------------------------------------------
  // Standard Insets
  // ---------------------------------------------------------------------------

  /// EdgeInsets.all(4.0)
  static const EdgeInsets insetsXXS = EdgeInsets.all(xxSmall);

  /// EdgeInsets.all(8.0)
  static const EdgeInsets insetsXS = EdgeInsets.all(xSmall);

  /// EdgeInsets.all(12.0)
  static const EdgeInsets insetsS = EdgeInsets.all(small);

  /// EdgeInsets.all(16.0)
  static const EdgeInsets insetsM = EdgeInsets.all(medium);

  /// EdgeInsets.all(20.0)
  static const EdgeInsets insetsL = EdgeInsets.all(large);

  /// EdgeInsets.all(24.0)
  static const EdgeInsets insetsXL = EdgeInsets.all(xLarge);

  /// EdgeInsets.all(32.0)
  static const EdgeInsets insetsXXL = EdgeInsets.all(xxLarge);
}
