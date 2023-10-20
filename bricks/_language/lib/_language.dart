library _language;

import 'package:_language/src/definition.dart';
import 'package:_language/src/language_model.dart';
import 'package:_language/src/local_datasource.dart';
import 'package:flutter/material.dart';

export 'src/language_model.dart';

abstract class LanguageBrickInterface {
  Future<String?> getCurrentLanguageCode();

  Future<void> setLanguageCode(String? languageCode);

  Future<List<Locale>> getSystemLocales();

  List<Language> getSupportedLanguages(String? currentLanguageCode);
}

class LanguageBrick extends LanguageBrickInterface {
  @override
  Future<String?> getCurrentLanguageCode() async {
    return await LocalDatasource().getLanguageCode();
  }

  @override
  Future<void> setLanguageCode(String? languageCode) async {
    await LocalDatasource().saveLanguageCode(languageCode);
  }

  @override
  Future<List<Locale>> getSystemLocales() async {
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    return systemLocales;
  }

  @override
  List<Language> getSupportedLanguages([String? currentLanguageCode]) {
    return allSupportedLanguages(currentLanguageCode);
  }
}
