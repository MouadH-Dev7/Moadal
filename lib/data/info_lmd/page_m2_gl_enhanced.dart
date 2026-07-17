import 'package:flutter/material.dart';

import 'package:moadal/data/subjects_data.dart';
import 'package:moadal/features/grade_calculator_page.dart';

class PageM2GLEnhanced extends StatelessWidget {
  const PageM2GLEnhanced({super.key});

  @override
  Widget build(BuildContext context) {
    return GradeCalculatorPage(
      pageTitle: 'Master 2 GL',
      storagePrefix: 'm2_gl',
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
