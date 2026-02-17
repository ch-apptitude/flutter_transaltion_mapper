import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_translation_mapper/app_localization_provider.dart';

class CustomLocalization {
  final Map<String, String> _entries;
  static final CustomLocalizationDelegate delegate =
      CustomLocalizationDelegate();

  CustomLocalization(this._entries);

  static CustomLocalization? of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization);
  }

  String get(String key, {Map<String, dynamic>? params}) {
    String? translation = _entries[key];

    if (translation == null) {
      return "??:$key";
    }

    // If no parameters provided, return translation as-is
    if (params == null || params.isEmpty) {
      return translation;
    }

    // Replace placeholders with actual values
    String result = translation;
    params.forEach((paramKey, paramValue) {
      result = result.replaceAll('{$paramKey}', paramValue.toString());
    });

    return result;
  }
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<CustomLocalization> {
  String filePrefix = 'app_';

  @override
  bool isSupported(Locale locale) =>
      TranslationMapper.supportedLocales.contains(locale);

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  Future<CustomLocalization> load(Locale locale) async {
    try {
      String language = locale.languageCode;
      developer.log(
        'Loading localization for language: $language',
        name: 'CustomLocalization',
      );

      String json = await rootBundle.loadString("lib/l10n/$filePrefix$language.arb");

      Map<String, dynamic> decoded;
      try {
        decoded = jsonDecode(json);
      } catch (e) {
        developer.log(
          'Failed to parse JSON for locale $language',
          name: 'CustomLocalization',
          error: e,
        );
        rethrow;
      }

      // Filter out metadata entries (keys starting with @) and ensure string values
      Map<String, String> entries = {};
      int skippedEntries = 0;

      decoded.forEach((key, value) {
        if (key.startsWith('@')) {
          // Skip metadata entries
          return;
        }

        if (value is String) {
          entries[key] = value;
        } else {
          skippedEntries++;
          developer.log(
            'Skipped non-string value for key "$key" (type: ${value.runtimeType})',
            name: 'CustomLocalization',
          );
        }
      });

      developer.log(
        'Loaded ${entries.length} translations for $language${skippedEntries > 0 ? " ($skippedEntries entries skipped)" : ""}',
        name: 'CustomLocalization',
      );

      return CustomLocalization(entries);
    } catch (e, stackTrace) {
      developer.log(
        'Failed to load custom localization for locale ${locale.languageCode}',
        name: 'CustomLocalization',
        error: e,
        stackTrace: stackTrace,
      );

      // Return empty localization as fallback to prevent app crash
      developer.log(
        'Returning empty localization as fallback',
        name: 'CustomLocalization',
      );
      return CustomLocalization({});
    }
  }
}
