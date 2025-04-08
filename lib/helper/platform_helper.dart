import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformHelper {
  /// Vérifie si l'application s'exécute sur iOS
  static bool get isIOS {
    return !kIsWeb && Platform.isIOS;
  }

  /// Vérifie si l'application s'exécute sur Android
  static bool get isAndroid {
    return !kIsWeb && Platform.isAndroid;
  }

  /// Vérifie si l'application s'exécute sur le Web
  static bool get isWeb {
    return kIsWeb;
  }

  /// Vérifie si l'application s'exécute sur macOS
  static bool get isMacOS {
    return !kIsWeb && Platform.isMacOS;
  }

  /// Obtient des informations détaillées sur la plateforme
  static Map<String, dynamic> getPlatformInfo() {
    if (kIsWeb) {
      return {
        'platform': 'Web',
        'isIOS': false,
        'isAndroid': false,
        'isMacOS': false,
        'version': 'N/A',
      };
    }

    return {
      'platform': Platform.operatingSystem,
      'isIOS': Platform.isIOS,
      'isAndroid': Platform.isAndroid,
      'isMacOS': Platform.isMacOS,
      'version': Platform.operatingSystemVersion,
    };
  }

  /// Affiche les informations de plateforme dans la console
  static void logPlatformInfo() {
    final info = getPlatformInfo();

    print('========== PLATEFORME INFO ==========');
    print('Plateforme: ${info['platform']}');
    print('Est-ce iOS? ${info['isIOS']}');
    print('Est-ce Android? ${info['isAndroid']}');
    print('Est-ce macOS? ${info['isMacOS']}');
    print('Version: ${info['version']}');
    print('======================================');
  }
}
