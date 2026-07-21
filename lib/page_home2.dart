import 'package:flutter/material.dart';

import 'package:moadal/about_page.dart';
import 'package:moadal/theme/app_theme.dart';
import 'package:moadal/univ/page_sp.dart';
import 'package:moadal/utils/haptic_feedback_helper.dart';
import 'package:moadal/widgets/animated_option_card.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final stages = const [
    (
      title: 'Ecole primaire',
      subtitle: 'Calculez votre moyenne pour l\'ecole primaire',
      icon: Icons.school,
      route: null,
    ),
    (
      title: 'College',
      subtitle: 'Calculez votre moyenne pour le college',
      icon: Icons.menu_book,
      route: null,
    ),
    (
      title: 'Lycee',
      subtitle: 'Calculez votre moyenne pour le lycee',
      icon: Icons.auto_stories_rounded,
      route: null,
    ),
    (
      title: 'Universite',
      subtitle: 'Calculez votre moyenne universitaire',
      icon: Icons.history_edu,
      route: AssociationSpecializationsPage(),
    ),
  ];

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

  void _openStage(Widget? route, String title) {
    HapticFeedbackHelper.selectionClick();
    if (route != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => route));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title sera disponible prochainement')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moadel DZ'),
        leading: IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () {
            HapticFeedbackHelper.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutPage()),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.heroGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [AppTheme.softShadow],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choisissez votre niveau',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'Chaque parcours ouvrira les outils de calcul adaptes a votre niveau.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < stages.length; i++) ...[
            AnimatedOptionCard(
              animation: animation,
              index: i,
              title: stages[i].title,
              subtitle: stages[i].subtitle,
              icon: stages[i].icon,
              onTap: () => _openStage(stages[i].route, stages[i].title),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
