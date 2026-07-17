import 'package:flutter/material.dart';

import 'package:moadal/page_home2.dart';
import 'package:moadal/theme/app_theme.dart';
import 'package:moadal/utils/haptic_feedback_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark ? AppTheme.darkHeroGradient : AppTheme.heroGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [AppTheme.softShadow],
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: AppTheme.primaryColor,
                    size: screenWidth * 0.14,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Moadel DZ',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Votre calculateur de moyenne universitaire, simple et rapide.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    HapticFeedbackHelper.mediumImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage2()),
                    );
                  },
                  child: const Text('Commencer'),
                ),
                const Spacer(),
                Text(
                  'Copyright 2025 Moadel DZ',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
