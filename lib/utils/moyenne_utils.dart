import 'package:flutter/material.dart';

class CalculationsHelper {
  // 🔹 حساب معدل مادة واحدة
  static double calculerMoyenneModule({
    required String name,
    required Map<String, TextEditingController> tdControllers,
    required Map<String, TextEditingController> tpControllers,
    required Map<String, TextEditingController> examControllers,
  }) {
    double? td = double.tryParse(tdControllers[name]?.text ?? "");
    double? tp = double.tryParse(tpControllers[name]?.text ?? "");
    double? exam = double.tryParse(examControllers[name]?.text ?? "");

    if (exam == null) return 0.0;

    double moyenne;
    if (td != null && tp != null) {
      moyenne = ((td + tp) / 2) * 0.4 + exam * 0.6;
    } else if (td != null || tp != null) {
      moyenne = ((td ?? tp)!) * 0.4 + exam * 0.6;
    } else {
      moyenne = exam;
    }

    if (moyenne < 0) moyenne = 0;
    if (moyenne > 20) moyenne = 20;

    return double.parse(moyenne.toStringAsFixed(2));
  }

  // 🔹 حساب معدل فصل واحد + كريدي الفصل
  static double calculerMoyenneSemestre({
    required List<Map<String, dynamic>> semestre,
    required Map<String, double> moyennes,
    required Function(int) onCreditsUpdated,
  }) {
    double somme = 0;
    int totalCoef = 0;
    int totalCredits = 0;

    for (var s in semestre) {
      double m = moyennes[s["name"]] ?? 0;
      somme += m * (s["coef"] as num).toDouble();
      totalCoef += (s["coef"] as num).toInt();

      if (m >= 10) totalCredits += (s["credit"] as num).toInt();
    }

    double moyenneSemestre = totalCoef == 0 ? 0 : somme / totalCoef;

    // ✅ إذا كان المعدل الفصلي >=10 نكمل الكريدي إلى 30
    if (moyenneSemestre >= 10 && totalCredits < 30) {
      totalCredits = 30;
    }

    onCreditsUpdated(totalCredits);
    return moyenneSemestre;
  }

  // 🔹 حساب معدل UE
  // 🔹 حساب معدل وكريدي UE
  static Map<String, dynamic> calculerMoyenneEtCreditUE({
    required String ueName,
    required List<String> subjects,
    required List<Map<String, dynamic>> semestre,
    required Map<String, double> moyennes,
  }) {
    double somme = 0;
    int totalCredits = 0;
    int earnedCredits = 0;

    for (var name in subjects) {
      var matiere = semestre.firstWhere((s) => s["name"] == name);
      double m = moyennes[name] ?? 0;
      int credit = matiere["credit"];

      somme += m * credit;
      totalCredits += credit;

      if (m >= 10) earnedCredits += credit;
    }

    double moyenneUE = totalCredits == 0 ? 0 : somme / totalCredits;
    int finalCredits = moyenneUE >= 10 ? totalCredits : earnedCredits;

    return {
      "moyenne": double.parse(moyenneUE.toStringAsFixed(2)),
      "credits": finalCredits,
    };
  }

  // 🔹 حساب الكريدي السنوي الكلي
  static int calculerCreditsAnnuels({
    required double moyenneSem1,
    required double moyenneSem2,
    required int creditsSem1,
    required int creditsSem2,
  }) {
    double moyenneAnnuelle = (moyenneSem1 + moyenneSem2) / 2;

    if (moyenneAnnuelle >= 10) {
      return 60; // ✅ الكريدي الكامل للسنة
    } else {
      return creditsSem1 + creditsSem2; // ✅ المجموع الحقيقي للفصلين
    }
  }

  // 🔹 لون المعدل
  static Color getMoyenneColor(double moyenne) {
    if (moyenne >= 16) return Colors.green.shade800;
    if (moyenne >= 14) return Colors.green.shade500;
    if (moyenne >= 12) return Colors.yellow.shade700;
    if (moyenne >= 10) return Colors.orange.shade700;
    return Colors.red.shade700;
  }
}
