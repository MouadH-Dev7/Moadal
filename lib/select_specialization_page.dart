import 'package:flutter/material.dart';

import 'package:moadal/page_m1_ai.dart';
import 'package:moadal/page_m1_gl.dart';
import 'package:moadal/theme/app_theme.dart';
import 'package:moadal/utils/haptic_feedback_helper.dart';
import 'package:moadal/widgets/ad_banner_widget.dart';
import 'package:moadal/widgets/animated_option_card.dart';

class SelectSpecializationPage extends StatefulWidget {
  const SelectSpecializationPage({super.key});

  @override
  State<SelectSpecializationPage> createState() =>
      _SelectSpecializationPageState();
}

class _SelectSpecializationPageState extends State<SelectSpecializationPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final specializations = const [
    (
      title: 'Genie logiciel',
      subtitle: 'M1GL',
      icon: Icons.code_rounded,
      route: PageM1GLEnhanced(),
    ),
    (
      title: 'Intelligence artificielle',
      subtitle: 'M1AI',
      icon: Icons.psychology_rounded,
      route: PageM1AIEnhanced(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openPage(Widget page) {
    HapticFeedbackHelper.mediumImpact();
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Specialisation')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppTheme.pagePadding,
          AppTheme.pagePadding,
          AppTheme.pagePadding,
          24,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: isDark ? AppTheme.darkHeroGradient : AppTheme.heroGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [AppTheme.softShadow],
            ),
            child: Text(
              'Choisissez votre specialite pour ouvrir la grille de calcul adaptee.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < specializations.length; i++) ...[
            AnimatedOptionCard(
              animation: animation,
              index: i,
              title: specializations[i].title,
              subtitle: specializations[i].subtitle,
              icon: specializations[i].icon,
              trailing: ElevatedButton(
                onPressed: () => _openPage(specializations[i].route),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 42),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                ),
                child: const Text('Ouvrir'),
              ),
              onTap: () => _openPage(specializations[i].route),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}
