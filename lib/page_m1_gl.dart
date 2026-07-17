import 'package:flutter/material.dart';

import 'package:moadal/data/subjects_data.dart';
import 'package:moadal/features/grade_calculator_page.dart';

class PageM1GLEnhanced extends StatelessWidget {
  const PageM1GLEnhanced({super.key});

  @override
  Widget build(BuildContext context) {
    return GradeCalculatorPage(
      pageTitle: 'Master 1 GL',
      storagePrefix: 'm1_gl',
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
