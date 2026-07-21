import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class HapticHelper {
  HapticHelper._();

  static void light() => _run(HapticFeedback.lightImpact);
  static void medium() => _run(HapticFeedback.mediumImpact);
  static void heavy() => _run(HapticFeedback.heavyImpact);
  static void success() => _run(HapticFeedback.mediumImpact);
  static void error() => _run(HapticFeedback.heavyImpact);
  static void selection() => _run(HapticFeedback.selectionClick);

  static void _run(VoidCallback cb) {
    if (kIsWeb) return;
    try {
      cb();
    } catch (_) {}
  }
}