import 'package:flutter/widgets.dart';

typedef AppLocalizationsProvider = dynamic Function(BuildContext context);

class LocalizationProvider {
  static AppLocalizationsProvider? _provider;
  static List<Locale> _supportedLocales = [];

  /// Set the provider from the importing project
  static void setProvider(AppLocalizationsProvider provider) {
    _provider = provider;
  }

  /// Retrieve the AppLocalizations instance
  static dynamic getLocalizations(BuildContext context) {
    if (_provider == null) {
      throw FlutterError(
        'AppLocalizationsProvider is not set. '
        'Make sure to call LocalizationProvider.setProvider() in your app initialization.',
      );
    }
    return _provider!(context);
  }

  /// Set the supported locales
  static void setSupportedLocales(List<Locale> locales) {
    _supportedLocales = locales;
  }

  /// Get the supported locales
  static List<Locale> get supportedLocales => _supportedLocales;
}