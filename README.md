# Flutter Translation Mapper

A Flutter package designed to simplify localization by providing a project-agnostic solution for managing translations. This package allows you to use translation keys to fetch localized values and includes an extension for easier access to localization values. It also supports custom localization for dynamic translations.

## Features

- **Project-Agnostic Localization**: Easily integrate your own `AppLocalizations` class.
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

### 2. Set Up the `LocalizationProvider`

To make the package project-agnostic, you need to set the `LocalizationProvider` in your app. This allows the package to access your app's `AppLocalizations` class.

In your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_translation_mapper/localization_provider.dart';
import 'package:your_project_name/l10n/app_localizations.dart';

void main() {
  // Set the AppLocalizations provider
  LocalizationProvider.setProvider((BuildContext context) {
    return AppLocalizations.of(context);
  });

  // Set the supported locales
  LocalizationProvider.setSupportedLocales([
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
  supportedLocales: LocalizationProvider.supportedLocales,
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

---

### 5. Access Translations in Your App

#### Using the `loc` Extension

The package provides an extension on `BuildContext` to simplify accessing translations. For example:

```dart
Text(context.loc.welcomeMessage);
```

#### Using Custom Localization

For dynamic translations with variables, use the `translate` method:

```dart
Text(context.translate('greeting', params: {'name': 'John'}));
```

If the key is not found, the package will return `??:key` as a fallback.

---

## Why Use This Package?

When working with localization in Flutter, it can be cumbersome to use translation keys directly to fetch translations. This package solves that problem by:

1. Providing a project-agnostic way to integrate your localization logic.
2. Adding an extension to make accessing localization values simpler.
3. Supporting custom localization for dynamic translations.

---

## Limitations

- **No Advanced Formatting**: Currently, the custom localization only supports simple variable replacements. Plurals, dates, and other advanced formatting are not yet supported.
- **Manual Setup**: You need to manually set the `LocalizationProvider` and supported locales in your app.


