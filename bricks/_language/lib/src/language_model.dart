import 'package:flutter/material.dart';

class Language {
  Language({
    required this.code,
    required this.name,
    required this.flag,
    required this.systemLanguageTranslation,
  });

  final String? code;
  final String name;
  final Image flag;
  final String systemLanguageTranslation;
}
