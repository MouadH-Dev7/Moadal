import 'package:flutter/material.dart';

import 'package:moadal/data/info_lmd/subjects_m1_ai.dart';
import 'package:moadal/features/grade_calculator_page.dart';

class PageM1AIEnhanced extends StatelessWidget {
  const PageM1AIEnhanced({super.key});

  @override
  Widget build(BuildContext context) {
    return GradeCalculatorPage(
      pageTitle: 'Master 1 AI',
      storagePrefix: 'm1_ai',
      firstSemester: SemesterConfig(
        title: 'Semestre 1',
        subjects: semestre1Subjects,
        ueMap: ueSem1,
      ),
      secondSemester: SemesterConfig(
        title: 'Semestre 2',
        subjects: semestre2Subjects,
        ueMap: ueSem2,
      ),
    );
  }
}
