import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Politique de confidentialite')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Derniere mise a jour : 24 Octobre 2024',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          _Section(
            title: '1. Donnees collectees',
            body:
                'Nous stockons uniquement les donnees saisies dans l\'application pour calculer les moyennes et les credits.',
            bullets: const [
              'Noms des matieres',
              'Notes saisies',
              'Credits et moyennes',
            ],
          ),
          _Section(
            title: '2. Utilisation',
            body:
                'Ces donnees sont utilisees uniquement pour effectuer les calculs et afficher les resultats a l\'utilisateur.',
          ),
          _Section(
            title: '3. Stockage',
            body:
                'Les donnees sont conservees localement sur votre appareil via le stockage de l\'application. Elles ne sont pas partagees avec des tiers.',
          ),
          _Section(
            title: '4. Modifications',
            body:
                'Cette politique peut etre mise a jour lorsque l\'application evolue. Toute nouvelle version sera affichee sur cette page.',
          ),
          _Section(
            title: '5. Contact',
            body:
                'Pour toute question a propos de la confidentialite, vous pouvez nous ecrire a bmsoftwaresolutions0@gmail.com.',
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.body,
    this.bullets = const [],
  });

  final String title;
  final String body;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(body, style: Theme.of(context).textTheme.bodyMedium),
              if (bullets.isNotEmpty) ...[
                const SizedBox(height: 10),
                ...bullets.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('• $item'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
