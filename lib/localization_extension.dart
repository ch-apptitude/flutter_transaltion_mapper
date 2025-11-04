import 'package:flutter/material.dart';
import 'package:flutter_translation_mapper/app_localization_provider.dart';
import 'custom_localization.dart';

extension LocalizationExtension on BuildContext {
  /// Access AppLocalizations for type-safe translations
  /// Usage: `context.loc.welcomeToPimpay`
  dynamic get loc {
    return LocalizationProvider.getLocalizations(this);
  }

  /// Access translations by key using CustomLocalization
  /// Usage: `context.translate('myCustomKey')`
  String translate(String key, {Map<String, dynamic>? params}) {
    final customLoc = CustomLocalization.of(this);
    if (customLoc == null) {
      throw FlutterError(
        'CustomLocalization not found in context. '
        'Make sure CustomLocalization.delegate is added to localizationsDelegates.',
      );
    }
    return customLoc.get(key, params: params);
  }
}
