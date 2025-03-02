import 'package:flutter/widgets.dart';

extension SizedBoxExtension on num {
  /// Returns a SizedBox with a specific height.
  SizedBox get sizeHeight => SizedBox(height: toDouble());

  /// Returns a SizedBox with a specific width.
  SizedBox get sizeWidth => SizedBox(width: toDouble());
}
