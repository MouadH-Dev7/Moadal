import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    const sections = [
      (
        title: '1. Utilisation autorisee',
        body:
            'L\'application doit etre utilisee uniquement pour le calcul personnel et educatif des moyennes.',
      ),
      (
        title: '2. Proprietes intellectuelles',
        body:
            'Le contenu, le design et la structure de l\'application restent la propriete de leurs auteurs respectifs.',
      ),
      (
        title: '3. Donnees utilisateur',
        body:
            'Les notes et informations saisies servent uniquement a fournir les calculs dans l\'application.',
      ),
      (
        title: '4. Limitation de responsabilite',
        body:
            'L\'application aide au calcul, mais l\'utilisateur reste responsable de verifier les donnees saisies et les resultats obtenus.',
      ),
      (
        title: '5. Evolution du service',
        body:
            'Le contenu et les fonctionnalites peuvent etre modifies, ameliores ou retires sans preavis.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Conditions d\'utilisation')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'En utilisant cette application, vous acceptez les conditions suivantes.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          ...sections.map(
            (section) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        section.body,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
