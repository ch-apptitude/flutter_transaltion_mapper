import 'package:flutter/material.dart';
import 'custom_localization.dart';

extension LocalizationExtension on BuildContext {
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
