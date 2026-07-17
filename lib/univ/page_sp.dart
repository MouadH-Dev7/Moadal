import 'package:flutter/material.dart';

import 'package:moadal/univ/page_anne.dart';
import 'package:moadal/widgets/animated_option_card.dart';

class AssociationSpecializationsPage extends StatefulWidget {
  const AssociationSpecializationsPage({super.key});

  @override
  State<AssociationSpecializationsPage> createState() =>
      _AssociationSpecializationsPageState();
}

class _AssociationSpecializationsPageState
    extends State<AssociationSpecializationsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final specializations = const [
    (
      title: 'Informatique',
      subtitle: 'Programmes et activites educatives',
      icon: Icons.code_rounded,
      route: YearsPage(),
    ),
    (
      title: 'Sante',
      subtitle: 'Actions et campagnes de sante',
      icon: Icons.health_and_safety_outlined,
      route: null,
    ),
    (
      title: 'Environnement',
      subtitle: 'Projets de protection de la nature',
      icon: Icons.eco_outlined,
      route: null,
    ),
    (
      title: 'Culture et arts',
      subtitle: 'Evenements culturels et artistiques',
      icon: Icons.brush_outlined,
      route: null,
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

  void _openRoute(Widget? route, String title) {
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
      appBar: AppBar(title: const Text('Specialisations')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Text(
            'Selectionnez le domaine correspondant a votre parcours.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < specializations.length; i++) ...[
            AnimatedOptionCard(
              animation: animation,
              index: i,
              title: specializations[i].title,
              subtitle: specializations[i].subtitle,
              icon: specializations[i].icon,
              onTap: () =>
                  _openRoute(specializations[i].route, specializations[i].title),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
