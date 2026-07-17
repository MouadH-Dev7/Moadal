import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:moadal/theme/app_theme.dart';
import 'package:moadal/utils/haptic_feedback_helper.dart';
import 'package:moadal/utils/moyenne_utils.dart';
import 'package:moadal/widgets/ad_banner_widget.dart';

class SemesterConfig {
  const SemesterConfig({
    required this.title,
    required this.subjects,
    required this.ueMap,
  });

  final String title;
  final List<Map<String, dynamic>> subjects;
  final Map<String, List<String>> ueMap;

  int get totalCredits =>
      subjects.fold(0, (sum, subject) => sum + (subject['credit'] as int));
}

class GradeCalculatorPage extends StatefulWidget {
  const GradeCalculatorPage({
    required this.pageTitle,
    required this.storagePrefix,
    required this.firstSemester,
    required this.secondSemester,
    super.key,
  });

  final String pageTitle;
  final String storagePrefix;
  final SemesterConfig firstSemester;
  final SemesterConfig secondSemester;

  @override
  State<GradeCalculatorPage> createState() => _GradeCalculatorPageState();
}

class _GradeCalculatorPageState extends State<GradeCalculatorPage> {
  final Color primaryColor = AppTheme.primaryColor;
  final Map<String, TextEditingController> tdControllers = {};
  final Map<String, TextEditingController> tpControllers = {};
  final Map<String, TextEditingController> examControllers = {};
  final Map<String, ValueNotifier<double>> moyennes = {};
  final Map<String, ValueNotifier<double>> ueMoyennes = {};
  final Map<String, ValueNotifier<int>> ueCredits = {};

  final ValueNotifier<double> moyenneSem1N = ValueNotifier(0.0);
  final ValueNotifier<double> moyenneSem2N = ValueNotifier(0.0);
  final ValueNotifier<double> moyenneAnnuelleN = ValueNotifier(0.0);
  final ValueNotifier<int> creditsSem1N = ValueNotifier(0);
  final ValueNotifier<int> creditsSem2N = ValueNotifier(0);
  final ValueNotifier<int> creditsAnneeN = ValueNotifier(0);

  bool _isRestoringMarks = false;

  List<Map<String, dynamic>> get _allSubjects => [
    ...widget.firstSemester.subjects,
    ...widget.secondSemester.subjects,
  ];

  @override
  void initState() {
    super.initState();
    _initializeState();
    _loadSavedMarks();
  }

  void _initializeState() {
    for (final subject in _allSubjects) {
      final name = subject['name'] as String;
      tdControllers[name] = TextEditingController();
      tpControllers[name] = TextEditingController();
      examControllers[name] = TextEditingController();
      moyennes[name] = ValueNotifier(0.0);

      tdControllers[name]!.addListener(() => _mettreAJourMoyenne(name));
      tpControllers[name]!.addListener(() => _mettreAJourMoyenne(name));
      examControllers[name]!.addListener(() => _mettreAJourMoyenne(name));
    }

    for (final entry
        in {...widget.firstSemester.ueMap, ...widget.secondSemester.ueMap}
            .entries) {
      ueMoyennes[entry.key] = ValueNotifier(0.0);
      ueCredits[entry.key] = ValueNotifier(0);
    }
  }

  void _mettreAJourMoyenne(String name) {
    moyennes[name]!.value = CalculationsHelper.calculerMoyenneModule(
      name: name,
      tdControllers: tdControllers,
      tpControllers: tpControllers,
      examControllers: examControllers,
    );

    final isInFirstSemester = widget.firstSemester.subjects.any(
      (subject) => subject['name'] == name,
    );

    if (isInFirstSemester) {
      _mettreAJourSemestre(
        widget.firstSemester,
        moyenneSem1N,
        creditsSem1N,
      );
    } else {
      _mettreAJourSemestre(
        widget.secondSemester,
        moyenneSem2N,
        creditsSem2N,
      );
    }

    _updateAnnualSummary();
    _saveMarksIfNeeded();
  }

  void _mettreAJourSemestre(
    SemesterConfig semester,
    ValueNotifier<double> moyenneSemNotifier,
    ValueNotifier<int> creditsSemNotifier,
  ) {
    for (final entry in semester.ueMap.entries) {
      final result = CalculationsHelper.calculerMoyenneEtCreditUE(
        ueName: entry.key,
        subjects: entry.value,
        semestre: semester.subjects,
        moyennes: moyennes.map(
          (key, notifier) => MapEntry(key, notifier.value),
        ),
      );
      ueMoyennes[entry.key]!.value = result['moyenne'];
      ueCredits[entry.key]!.value = result['credits'];
    }

    var tmpCredits = 0;
    moyenneSemNotifier.value = CalculationsHelper.calculerMoyenneSemestre(
      semestre: semester.subjects,
      moyennes: moyennes.map((key, notifier) => MapEntry(key, notifier.value)),
      onCreditsUpdated: (credits) => tmpCredits = credits,
    );
    creditsSemNotifier.value = tmpCredits;
  }

  void _updateAnnualSummary() {
    final m1 = moyenneSem1N.value;
    final m2 = moyenneSem2N.value;
    moyenneAnnuelleN.value = (m1 + m2) / 2;
    creditsAnneeN.value = CalculationsHelper.calculerCreditsAnnuels(
      moyenneSem1: m1,
      moyenneSem2: m2,
      creditsSem1: creditsSem1N.value,
      creditsSem2: creditsSem2N.value,
    );
  }

  void _recalculateAll() {
    for (final name in moyennes.keys) {
      moyennes[name]!.value = CalculationsHelper.calculerMoyenneModule(
        name: name,
        tdControllers: tdControllers,
        tpControllers: tpControllers,
        examControllers: examControllers,
      );
    }

    _mettreAJourSemestre(widget.firstSemester, moyenneSem1N, creditsSem1N);
    _mettreAJourSemestre(widget.secondSemester, moyenneSem2N, creditsSem2N);
    _updateAnnualSummary();
  }

  void _resetFields() {
    HapticFeedbackHelper.mediumImpact();
    for (final controller in tdControllers.values) {
      controller.clear();
    }
    for (final controller in tpControllers.values) {
      controller.clear();
    }
    for (final controller in examControllers.values) {
      controller.clear();
    }
    for (final notifier in moyennes.values) {
      notifier.value = 0.0;
    }
    for (final notifier in ueMoyennes.values) {
      notifier.value = 0.0;
    }
    for (final notifier in ueCredits.values) {
      notifier.value = 0;
    }

    moyenneSem1N.value = 0.0;
    moyenneSem2N.value = 0.0;
    moyenneAnnuelleN.value = 0.0;
    creditsSem1N.value = 0;
    creditsSem2N.value = 0;
    creditsAnneeN.value = 0;

    _saveMarksIfNeeded();
  }

  void _saveMarksIfNeeded() {
    if (_isRestoringMarks) {
      return;
    }
    _saveMarks();
  }

  Future<void> _saveMarks() async {
    final prefs = await SharedPreferences.getInstance();
    for (final name in tdControllers.keys) {
      await prefs.setString(
        '${widget.storagePrefix}_td_$name',
        tdControllers[name]!.text,
      );
      await prefs.setString(
        '${widget.storagePrefix}_tp_$name',
        tpControllers[name]!.text,
      );
      await prefs.setString(
        '${widget.storagePrefix}_exam_$name',
        examControllers[name]!.text,
      );
    }
  }

  Future<void> _loadSavedMarks() async {
    final prefs = await SharedPreferences.getInstance();
    _isRestoringMarks = true;

    try {
      for (final name in tdControllers.keys) {
        tdControllers[name]!.text =
            prefs.getString('${widget.storagePrefix}_td_$name') ?? '';
        tpControllers[name]!.text =
            prefs.getString('${widget.storagePrefix}_tp_$name') ?? '';
        examControllers[name]!.text =
            prefs.getString('${widget.storagePrefix}_exam_$name') ?? '';
      }
    } finally {
      _isRestoringMarks = false;
    }

    _recalculateAll();
  }

  Widget _buildNoteField(
    TextEditingController controller,
    String hint,
    bool enabled,
  ) {
    return SizedBox(
      width: 74,
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')),
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            return;
          }

          final parsed = double.tryParse(value);
          if (parsed != null && parsed > 20) {
            controller.text = '20';
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 6,
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    final name = subject['name'] as String;
    final displayName = (subject['displayName'] ?? name) as String;
    final moyenneNotifier = moyennes[name]!;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    displayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Coef : ${subject['coef']}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Credit : ${subject['credit']}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (subject['hasTD'] as bool)
                  _buildNoteField(tdControllers[name]!, "TD", true)
                else
                  const SizedBox(width: 74),
                const SizedBox(width: 8),
                if (subject['hasTP'] as bool)
                  _buildNoteField(tpControllers[name]!, "TP", true)
                else
                  const SizedBox(width: 74),
                const SizedBox(width: 8),
                _buildNoteField(examControllers[name]!, "Exam", true),
              ],
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<double>(
              valueListenable: moyenneNotifier,
              builder: (context, moyenne, child) {
                return Row(
                  children: [
                    Text(
                      "Moy: ${moyenne.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CalculationsHelper.getMoyenneColor(moyenne),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      moyenne >= 10 ? "Validee" : "Non validee",
                      style: TextStyle(
                        color: moyenne >= 10 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUEFooter(String ueName) {
    final moyenneNotifier = ueMoyennes[ueName]!;
    final creditsNotifier = ueCredits[ueName]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Card(
        color: Colors.grey.shade100,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ValueListenableBuilder<double>(
                valueListenable: moyenneNotifier,
                builder: (_, moyenneUE, __) => Text(
                  "Moyenne UE : ${moyenneUE.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: CalculationsHelper.getMoyenneColor(moyenneUE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              ValueListenableBuilder<int>(
                valueListenable: creditsNotifier,
                builder: (_, creditsUE, __) => Text(
                  "Credits : $creditsUE",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemestreCards(SemesterConfig semester) {
    final cards = <Widget>[];
    for (final entry in semester.ueMap.entries) {
      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            entry.key,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );

      for (final name in entry.value) {
        final subject = semester.subjects.firstWhere(
          (item) => item['name'] == name,
        );
        cards.add(_buildSubjectCard(subject));
      }

      cards.add(_buildUEFooter(entry.key));
    }

    return Column(children: cards);
  }

  Widget _buildSemestreFooter(
    SemesterConfig semester,
    ValueNotifier<double> moyenneNotifier,
    ValueNotifier<int> creditsNotifier,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Card(
        color: primaryColor.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<double>(
                valueListenable: moyenneNotifier,
                builder: (_, moyenne, __) => Text(
                  "${semester.title} : ${moyenne.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CalculationsHelper.getMoyenneColor(moyenne),
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              ValueListenableBuilder<int>(
                valueListenable: creditsNotifier,
                builder: (_, credits, __) => Text(
                  "Credits obtenus : $credits / ${semester.totalCredits}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemesterSection(
    SemesterConfig semester,
    ValueNotifier<double> moyenneNotifier,
    ValueNotifier<int> creditsNotifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          semester.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildSemestreCards(semester),
        _buildSemestreFooter(semester, moyenneNotifier, creditsNotifier),
      ],
    );
  }

  Widget _buildAnnualSummary() {
    final totalCredits =
        widget.firstSemester.totalCredits + widget.secondSemester.totalCredits;

    return Center(
      child: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: moyenneAnnuelleN,
            builder: (_, value, __) => Text(
              "Moyenne Annuelle : ${value.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<int>(
            valueListenable: creditsAnneeN,
            builder: (_, value, __) => Text(
              "Credits obtenus sur l'annee : $value / $totalCredits",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<double>(
            valueListenable: moyenneAnnuelleN,
            builder: (_, value, __) => Text(
              value >= 10 ? "Annee validee" : "Annee non validee",
              style: TextStyle(
                color: value >= 10
                    ? Colors.green.shade700
                    : Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showResetDialog() async {
    HapticFeedbackHelper.mediumImpact();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reinitialiser'),
        content: const Text(
          'Etes-vous sur de vouloir reinitialiser tous les champs ?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              Navigator.pop(context);
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              HapticFeedbackHelper.mediumImpact();
              Navigator.pop(context);
              _resetFields();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tous les champs ont ete reinitialises'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Reinitialiser'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in tdControllers.values) {
      controller.dispose();
    }
    for (final controller in tpControllers.values) {
      controller.dispose();
    }
    for (final controller in examControllers.values) {
      controller.dispose();
    }
    for (final notifier in moyennes.values) {
      notifier.dispose();
    }
    for (final notifier in ueMoyennes.values) {
      notifier.dispose();
    }
    for (final notifier in ueCredits.values) {
      notifier.dispose();
    }

    moyenneSem1N.dispose();
    moyenneSem2N.dispose();
    moyenneAnnuelleN.dispose();
    creditsSem1N.dispose();
    creditsSem2N.dispose();
    creditsAnneeN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.primaryColor : primaryColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedbackHelper.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.pageTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Reinitialiser tous les champs",
            onPressed: _showResetDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSemesterSection(
              widget.firstSemester,
              moyenneSem1N,
              creditsSem1N,
            ),
            const Divider(height: 40, thickness: 1.5),
            _buildSemesterSection(
              widget.secondSemester,
              moyenneSem2N,
              creditsSem2N,
            ),
            const SizedBox(height: 20),
            _buildAnnualSummary(),
          ],
        ),
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}
