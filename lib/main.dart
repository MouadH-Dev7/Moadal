import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:moadal/firebase_options.dart';
import 'package:moadal/screens/splash_screen.dart';
import 'package:moadal/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAnalytics? analytics;
  if (_supportsFirebaseInitialization) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      analytics = FirebaseAnalytics.instance;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Firebase initialization warning: $e');
      }
    }
  }

  try {
    await MobileAds.instance.initialize();
  } catch (e) {
    if (kDebugMode) {
      debugPrint('AdMob initialization warning: $e');
    }
  }

  runApp(MyApp(analytics: analytics));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.analytics});

  final FirebaseAnalytics? analytics;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moadel DZ',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        if (analytics != null)
          FirebaseAnalyticsObserver(analytics: analytics!),
      ],
      home: const SplashScreen(),
    );
  }
}

bool get _supportsFirebaseInitialization {
  if (kIsWeb) {
    return false;
  }
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
