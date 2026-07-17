import 'package:flutter/material.dart';

import 'package:moadal/data/info_lmd/page_sp_m2.dart';
import 'package:moadal/select_specialization_page.dart';
import 'package:moadal/widgets/animated_option_card.dart';

class YearsPage extends StatefulWidget {
  const YearsPage({super.key});

  @override
  State<YearsPage> createState() => _YearsPageState();
}

class _YearsPageState extends State<YearsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final programs = const {
    'LMD': [
      (
        title: 'L1',
        subtitle: 'Premiere annee licence',
        icon: Icons.school_outlined,
        route: null,
      ),
      (
        title: 'L2',
        subtitle: 'Deuxieme annee licence',
        icon: Icons.menu_book_outlined,
        route: null,
      ),
      (
        title: 'L3',
        subtitle: 'Troisieme annee licence',
        icon: Icons.auto_stories_outlined,
        route: null,
      ),
      (
        title: 'M1',
        subtitle: 'Premiere annee master',
        icon: Icons.grade_outlined,
        route: SelectSpecializationPage(),
      ),
      (
        title: 'M2',
        subtitle: 'Deuxieme annee master',
        icon: Icons.workspace_premium_outlined,
        route: SelectSpecializationPage2(),
      ),
    ],
    'Ingenieur': [
      (
        title: 'ING1',
        subtitle: 'Premiere annee ingenieur',
        icon: Icons.engineering_outlined,
        route: null,
      ),
      (
        title: 'ING2',
        subtitle: 'Deuxieme annee ingenieur',
        icon: Icons.settings_applications_outlined,
        route: null,
      ),
      (
        title: 'ING3',
        subtitle: 'Troisieme annee ingenieur',
        icon: Icons.construction_outlined,
        route: null,
      ),
      (
        title: 'ING4',
        subtitle: 'Quatrieme annee ingenieur',
        icon: Icons.design_services_outlined,
        route: null,
      ),
      (
        title: 'ING5',
        subtitle: 'Cinquieme annee ingenieur',
        icon: Icons.precision_manufacturing_outlined,
        route: null,
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openRoute(Widget? route, String title) {
    if (route != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => route));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('La page $title sera disponible prochainement')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Annees universitaires')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          for (final entry in programs.entries) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            for (var i = 0; i < entry.value.length; i++) ...[
              AnimatedOptionCard(
                animation: animation,
                index: i,
                title: entry.value[i].title,
                subtitle: entry.value[i].subtitle,
                icon: entry.value[i].icon,
                onTap: () =>
                    _openRoute(entry.value[i].route, entry.value[i].title),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
