import 'package:flutter/material.dart';

import 'package:moadal/data/info_lmd/subjects_m1_ai.dart';
import 'package:moadal/features/grade_calculator_page.dart';

class PageM2AIEnhanced extends StatelessWidget {
  const PageM2AIEnhanced({super.key});

  @override
  Widget build(BuildContext context) {
    return GradeCalculatorPage(
      pageTitle: 'Master 2 AI',
      storagePrefix: 'm2_ai',
      firstSemester: SemesterConfig(
        title: 'Semestre 3',
        subjects: semestre3Subjects,
        ueMap: ueSem3,
      ),
      secondSemester: SemesterConfig(
        title: 'Semestre 4',
        subjects: semestre4Subjects,
        ueMap: ueSem4,
      ),
    );
  }
}
