# Flutter Translation Mapper

A Flutter package designed to simplify localization by providing a solution for managing custom translations with variable support. This package allows you to use translation keys to fetch localized values with dynamic variable replacements.

## Features

- **Key-Based Translations**: Use translation keys to fetch localized values.
- **Simplified Access**: Access translations directly using an extension on `BuildContext`.
- **Custom Localization**: Supports dynamic translations with simple variable replacements.
- **Fallback Support**: Prevents crashes by providing fallback translations.

> **Note**: Currently, the custom localization only supports simple variables. Plurals, dates, and other advanced formatting are not yet supported.

---

## Getting Started

### 1. Add the Package to Your Project

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_translation_mapper: ^1.0.0
```

Run `flutter pub get` to fetch the package.

---

### 2. Set Up the Supported Locales

In your `main.dart`, configure the supported locales:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_translation_mapper/app_localization_provider.dart';

void main() {
  // Set the supported locales
  TranslationMapper.setSupportedLocales([
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ]);

  runApp(MyApp());
}
```

---

### 3. Add the Custom Localization Delegate

To use the custom localization feature, add the `CustomLocalization.delegate` to your app's `localizationsDelegates` and `supportedLocales`.

In your `MaterialApp`:

```dart
import 'package:flutter_translation_mapper/custom_localization.dart';

MaterialApp(
  localizationsDelegates: [
    CustomLocalization.delegate,
    // Add other delegates like AppLocalizations.delegate
  ],
  supportedLocales: TranslationMapper.supportedLocales,
  home: MyHomePage(),
);
```

---

### 4. Add Your Translation Files

Place your `.arb` files in the `lib/l10n` directory. For example:

- `lib/l10n/app_en.arb`
- `lib/l10n/app_es.arb`

Each file should contain key-value pairs for translations:

```json
{
  "welcomeMessage": "Welcome to our app!",
  "greeting": "Hello, {name}!"
}
```

#### Customizing the File Prefix

By default, the package looks for translation files with the `app_` prefix (e.g., `app_en.arb`, `app_es.arb`). You can customize this prefix to match your project's naming convention:

```dart
void main() {
  TranslationMapper.setSupportedLocales([
    Locale('en'),
    Locale('es'),
  ]);

  // Customize the file prefix (default is 'app_')
  CustomLocalization.delegate.filePrefix = 'translations_';

  runApp(MyApp());
}
```

With the custom prefix `translations_`, the package will load:
- `lib/l10n/translations_en.arb`
- `lib/l10n/translations_es.arb`

---

### 5. Access Translations in Your App

Use the `translate` method for translations with or without variables:

```dart
// Simple translation
Text(context.translate('welcomeMessage'));

// Translation with variables
Text(context.translate('greeting', params: {'name': 'John'}));
```

If the key is not found, the package will return `??:key` as a fallback.

---

## Optional: Add a Convenience Extension for AppLocalizations

If you're using Flutter's built-in `AppLocalizations` and want quick access to variable-based translations, you can add this extension to your project:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
```

This allows you to access your standard localizations easily:

```dart
Text(context.loc.welcomeMessage);
```

---

## Why Use This Package?

When working with localization in Flutter, it can be cumbersome to manage dynamic translations with variable replacements. This package solves that problem by:

1. Providing a simple way to manage custom translations with variable support.
2. Adding an extension to make accessing translations easier with `context.translate()`.
3. Supporting custom localization for dynamic translations.
4. Providing fallback support to prevent crashes when keys are missing.

---

## Limitations

- **No Advanced Formatting**: Currently, the custom localization only supports simple variable replacements. Plurals, dates, and other advanced formatting are not yet supported.
- **Manual Setup**: You need to manually set the supported locales and add the delegate in your app.


