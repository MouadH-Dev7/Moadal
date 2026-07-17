import 'package:flutter/material.dart';

import 'package:moadal/contact_page.dart';
import 'package:moadal/privacy_policy_page.dart';
import 'package:moadal/terms_of_use_page.dart';
import 'package:moadal/theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = [
      (
        title: 'Conditions d\'utilisation',
        icon: Icons.description_outlined,
        page: const TermsOfUsePage(),
      ),
      (
        title: 'Politique de confidentialite',
        icon: Icons.privacy_tip_outlined,
        page: const PrivacyPolicyPage(),
      ),
      (
        title: 'Contactez-nous',
        icon: Icons.mail_outline,
        page: const ContactPage(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('A propos')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: isDark ? AppTheme.darkHeroGradient : AppTheme.heroGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [AppTheme.softShadow],
            ),
            child: Column(
              children: [
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 52,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Moadel DZ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Calculateur de moyenne universitaire',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Version 1.0.2',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(item.icon, color: AppTheme.primaryColor),
                  ),
                  title: Text(item.title),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item.page),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Copyright 2025 Moadel DZ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
