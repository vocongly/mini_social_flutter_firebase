import 'package:_language/_language.dart';
import 'package:_language/src/constant.dart';
import 'package:_language/src/helper.dart';
import 'package:flutter/material.dart';

List<Language> allSupportedLanguages([String? currentLanguageCode]) {
  List<Language> languageData = [
    Vietnamese(),
    English(),
    Japanese(),
    Korean(),
    French(),
    Chinese(),
  ];
  languageData = sortLanguageByName(languageData);
  languageData.insert(0, SystemLanguage(currentLanguageCode));
  return languageData;
}

class SystemLanguage extends Language {
  SystemLanguage([String? currentLanguageCode])
      : super(
          code: null,
          name: translateSystemLanguageByCode(currentLanguageCode),
          flag: Image.asset(
            ImagePath.systemLanguageFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "",
        );
}

class Vietnamese extends Language {
  Vietnamese()
      : super(
          code: "vi",
          name: "Tiếng Việt",
          flag: Image.asset(
            ImagePath.vietnamFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "Ngôn ngữ hệ thống",
        );
}

class English extends Language {
  English()
      : super(
          code: "en",
          name: "English",
          flag: Image.asset(
            ImagePath.ukFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "System language",
        );
}

class Japanese extends Language {
  Japanese()
      : super(
          code: "ja",
          name: "日本語",
          flag: Image.asset(
            ImagePath.japanFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "システム言語",
        );
}

class Korean extends Language {
  Korean()
      : super(
          code: "ko",
          name: "한국어",
          flag: Image.asset(
            ImagePath.koreaFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "시스템 언어",
        );
}

class French extends Language {
  French()
      : super(
          code: "fr",
          name: "français",
          flag: Image.asset(
            ImagePath.franceFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "Langue du système",
        );
}

class Chinese extends Language {
  Chinese()
      : super(
          code: "zh",
          name: "简体中文",
          flag: Image.asset(
            ImagePath.chinaFlag,
            package: brickName,
            fit: BoxFit.contain,
          ),
          systemLanguageTranslation: "系统语言",
        );
}
