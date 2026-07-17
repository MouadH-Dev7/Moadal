// lib/data/subjects_data_i2a.dart
// 🎓 Master Intelligence Artificielle Appliquée (IAA) - UMBB
// Année universitaire 2025/2026

// ---------------------------------------------------------------------------
// 🧩 Semestre 1
// ---------------------------------------------------------------------------

final List<Map<String, dynamic>> semestre1Subjects = [
  // UE Fondamentale UEF1(O/P)
  {
    "name": "Apprentissage automatique",
    "coef": 3,
    "credit": 6,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Bases de données avancées",
    "coef": 3,
    "credit": 6,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Réseaux avancés",
    "coef": 3,
    "credit": 6,
    "hasTD": true,
    "hasTP": true,
  },

  // UE Méthodologique UEM1(O/P)
  {
    "name": "Python avancé pour la science des données",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Traitement et analyse d’images",
    "coef": 3,
    "credit": 5,
    "hasTD": false,
    "hasTP": true,
  },

  // UE Découverte UED1(O/P)
  {
    "name": "Cloud Computing et Big Data",
    "coef": 2,
    "credit": 2,
    "hasTD": false,
    "hasTP": true,
  },

  // UE Transversale UET1(O/P)
  {
    "name": "Séminaires et workshops",
    "coef": 1,
    "credit": 1,
    "hasTD": false,
    "hasTP": false,
  },
];

final Map<String, List<String>> ueSem1 = {
  "UE Fondamentale UEF1(O/P)": [
    "Apprentissage automatique",
    "Bases de données avancées",
    "Réseaux avancés",
  ],
  "UE Méthodologique UEM1(O/P)": [
    "Python avancé pour la science des données",
    "Traitement et analyse d’images",
  ],
  "UE Découverte UED1(O/P)": ["Cloud Computing et Big Data"],
  "UE Transversale UET1(O/P)": ["Séminaires et workshops"],
};

// ---------------------------------------------------------------------------
// 🧩 Semestre 2
// ---------------------------------------------------------------------------

final List<Map<String, dynamic>> semestre2Subjects = [
  // UE Fondamentale UEF2(O/P)
  {
    "name": "Méthodes de conception avancées",
    "coef": 2,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Apprentissage profond",
    "coef": 3,
    "credit": 6,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Calcul haute performance",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Algorithmique avancée et complexité",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },

  // UE Méthodologique UEM2(O/P)
  {
    "name": "Optimisation et métaheuristiques",
    "coef": 3,
    "credit": 5,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "Processus stochastiques",
    "coef": 2,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },

  // UE Découverte UED2(O/P)
  {
    "name": "Web avancé et micro-services",
    "coef": 2,
    "credit": 2,
    "hasTD": false,
    "hasTP": true,
  },

  // UE Transversale UET2(O/P)
  {
    "name": "Séminaire et workshops",
    "coef": 1,
    "credit": 1,
    "hasTD": false,
    "hasTP": false,
  },
];

final Map<String, List<String>> ueSem2 = {
  "UE Fondamentale UEF2(O/P)": [
    "Méthodes de conception avancées",
    "Apprentissage profond",
    "Calcul haute performance",
    "Algorithmique avancée et complexité",
  ],
  "UE Méthodologique UEM2(O/P)": [
    "Optimisation et métaheuristiques",
    "Processus stochastiques",
  ],
  "UE Découverte UED2(O/P)": ["Web avancé et micro-services"],
  "UE Transversale UET2(O/P)": ["Séminaire et workshops"],
};

// ---------------------------------------------------------------------------
// 🧩 Semestre 3
// ---------------------------------------------------------------------------

final List<Map<String, dynamic>> semestre3Subjects = [
  // UE Fondamentale UEF3(O/P)
  {
    "name": "Reconnaissance des formes et vision artificielle",
    "coef": 3,
    "credit": 6,
    "hasTD": true,
    "hasTP": true,
  },
  {
    "name": "Traitement du langage naturel",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },
  {
    "name": "IA générative",
    "coef": 2,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Business Intelligence",
    "coef": 2,
    "credit": 4,
    "hasTD": true,
    "hasTP": false,
  },

  // UE Méthodologique UEM3(O/P)
  {
    "name": "Systèmes multi-agents",
    "coef": 3,
    "credit": 5,
    "hasTD": true,
    "hasTP": false,
  },
  {
    "name": "Systèmes embarqués et IoT",
    "coef": 2,
    "credit": 4,
    "hasTD": false,
    "hasTP": true,
  },

  // UE Découverte UED3(O/P)
  {
    "name": "Startup and Professional Development",
    "coef": 2,
    "credit": 2,
    "hasTD": true,
    "hasTP": false,
  },

  // UE Transversale UET3(O/P)
  {
    "name": "Séminaire et workshops",
    "coef": 1,
    "credit": 1,
    "hasTD": false,
    "hasTP": false,
  },
];

final Map<String, List<String>> ueSem3 = {
  "UE Fondamentale UEF3(O/P)": [
    "Reconnaissance des formes et vision artificielle",
    "Traitement du langage naturel",
    "IA générative",
    "Business Intelligence",
  ],
  "UE Méthodologique UEM3(O/P)": [
    "Systèmes multi-agents",
    "Systèmes embarqués et IoT",
  ],
  "UE Découverte UED3(O/P)": ["Startup and Professional Development"],
  "UE Transversale UET3(O/P)": ["Séminaire et workshops"],
};

// ---------------------------------------------------------------------------
// 🧩 Semestre 4 - Projet de Fin d'Études (PFE)
// ---------------------------------------------------------------------------

final List<Map<String, dynamic>> semestre4Subjects = [
  {
    "name": "Projet de Fin d'Études (PFE)",
    "coef": 1,
    "credit": 30,
    "hasTD": false,
    "hasTP": false,
  },
];

final Map<String, List<String>> ueSem4 = {
  "UE Projet de Fin d'Études": ["Projet de Fin d'Études (PFE)"],
};
