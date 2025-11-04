import 'package:flutter/widgets.dart';

typedef AppLocalizationsProvider<T> = T Function(BuildContext context);

class LocalizationProvider<T> {
  static LocalizationProvider? _instance;
  final AppLocalizationsProvider<T> _provider;
  static List<Locale> _supportedLocales = [];

  LocalizationProvider._(this._provider);

  /// Set the provider from the importing project
  static void setProvider<T>(AppLocalizationsProvider<T> provider) {
    _instance = LocalizationProvider<T>._(provider);
  }

  /// Retrieve the AppLocalizations instance
  static T getLocalizations<T>(BuildContext context) {
    if (_instance == null) {
      throw FlutterError(
        'AppLocalizationsProvider is not set. '
        'Make sure to call LocalizationProvider.setProvider() in your app initialization.',
      );
    }
    return (_instance as LocalizationProvider<T>)._provider(context);
  }

  /// Set the supported locales
  static void setSupportedLocales(List<Locale> locales) {
    _supportedLocales = locales;
  }

  /// Get the supported locales
  static List<Locale> get supportedLocales => _supportedLocales;
}