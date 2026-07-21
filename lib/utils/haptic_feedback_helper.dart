import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class HapticFeedbackHelper {
  HapticFeedbackHelper._();

  static void lightImpact() => _run(HapticFeedback.lightImpact);
  static void mediumImpact() => _run(HapticFeedback.mediumImpact);
  static void heavyImpact() => _run(HapticFeedback.heavyImpact);
  static void success() => _run(HapticFeedback.mediumImpact);
  static void error() => _run(HapticFeedback.heavyImpact);
  static void selectionClick() => _run(HapticFeedback.selectionClick);

  static void _run(VoidCallback cb) {
    if (kIsWeb) return;
    try {
      cb();
    } catch (_) {}
  }
}