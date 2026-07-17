import 'package:flutter/services.dart';

class HapticFeedbackHelper {
  // Haptic Feedback خفيف للأزرار العادية
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  // Haptic Feedback متوسط للأزرار المهمة
  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  // Haptic Feedback قوي للأحداث المهمة
  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  // Haptic Feedback للنجاح
  static void success() {
    HapticFeedback.mediumImpact();
  }

  // Haptic Feedback للخطأ
  static void error() {
    HapticFeedback.heavyImpact();
  }

  // Haptic Feedback للاختيار
  static void selection() {
    HapticFeedback.selectionClick();
  }
}
