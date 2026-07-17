// lib/data/subjects_data.dart
final List<Map<String, dynamic>> semestre1Subjects = [
  {
    "name": "Algorithmique Avancée & Complexité",
    "coef": 3,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Bases de Données Avancées",
    "coef": 3,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Ingénierie des Exigences",
    "coef": 3,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Méthodes de Conception de Logiciels & Design Patterns",
    "coef": 3,
    "credit": 4,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Compilation Avancée",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Paradigmes de Programmation",
    "coef": 2,
    "credit": 5,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Réseaux Avancés",
    "coef": 1,
    "credit": 2,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Un module au choix (S1)",
    "displayName": "Un module au choix",
    "coef": 1,
    "credit": 1,
    "hasTD": false,
    "hasTP": false,
  },
];

final List<Map<String, dynamic>> semestre2Subjects = [
  {
    "name": "Architectures Logicielles",
    "coef": 3,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Architectures Orientées Services",
    "coef": 3,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Systèmes d’Information Coopératifs",
    "coef": 3,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Sémantiques Formelles des Langages de Programmation",
    "coef": 3,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Systèmes Multi Agents",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Machine Learning",
    "coef": 2,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Gestion de Projets Informatiques",
    "coef": 1,
    "credit": 2,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Un module au choix (S2)",
    "displayName": "Un module au choix",
    "coef": 1,
    "credit": 1,
    "hasTD": false,
    "hasTP": false,
  },
];

final Map<String, List<String>> ueSem1 = {
  "UE Fondamentales UEF11": [
    "Algorithmique Avancée & Complexité",
    "Bases de Données Avancées",
  ],
  "UE Fondamentales UEF12": [
    "Ingénierie des Exigences",
    "Méthodes de Conception de Logiciels & Design Patterns",
  ],
  "UE Méthodologique UEM1": [
    "Compilation Avancée",
    "Paradigmes de Programmation",
  ],
  "UE Transversale UET1": ["Réseaux Avancés"],
  "UE Découverte": ["Un module au choix (S1)"],
};

final Map<String, List<String>> ueSem2 = {
  "UE Fondamentales UEF21": [
    "Architectures Logicielles",
    "Architectures Orientées Services",
  ],
  "UE Fondamentales UEF22": [
    "Systèmes d’Information Coopératifs",
    "Sémantiques Formelles des Langages de Programmation",
  ],
  "UE Méthodologique UEM2": ["Systèmes Multi Agents", "Machine Learning"],
  "UE Transversale UET2": ["Gestion de Projets Informatiques"],
  "UE Découverte UED2": ["Un module au choix (S2)"],
};

final List<Map<String, dynamic>> semestre3Subjects = [
  {
    "name": "Assurance Qualité & Tests des Logiciels",
    "coef": 3,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "DevOps & Maintenance des Logiciels",
    "coef": 3,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Ingénierie Dirigée par les Modèles",
    "coef": 3,
    "credit": 5,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Spécification et Vérification Formelle",
    "coef": 3,
    "credit": 4,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Modélisation et Évaluation des Performances des Systèmes",
    "coef": 2,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Big Data Analytics",
    "coef": 2,
    "credit": 5,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Méthodologies de Recherche",
    "coef": 1,
    "credit": 2,
    "hasTD": false,
    "hasTP": false,
  },
  {
    "name": "Un module au choix (S3)",
    "displayName": "Un module au choix",
    "coef": 1,
    "credit": 1,
    "hasTD": false,
    "hasTP": false,
  },
];

final List<Map<String, dynamic>> semestre4Subjects = [
  {
    "name": "Projet de Fin d’Études (PFE)",
    "coef": 1,
    "credit": 30,
    "hasTD": false,
    "hasTP": false,
  },
];

final Map<String, List<String>> ueSem3 = {
  "UE Fondamentales UEF31": [
    "Assurance Qualité & Tests des Logiciels",
    "DevOps & Maintenance des Logiciels",
  ],
  "UE Fondamentales UEF32": [
    "Ingénierie Dirigée par les Modèles",
    "Spécification et Vérification Formelle",
  ],
  "UE Méthodologique UEM3": [
    "Modélisation et Évaluation des Performances des Systèmes",
    "Big Data Analytics",
  ],
  "UE Transversale UET3": ["Méthodologies de Recherche"],
  "UE Découverte UED3": ["Un module au choix (S3)"],
};

final Map<String, List<String>> ueSem4 = {
  "UE Projet de Fin d’Études (UEPFE)": ["Projet de Fin d’Études (PFE)"],
};
