import 'package:_language/_language.dart';
import 'package:_language/src/definition.dart';

List<Language> sortLanguageByName(List<Language> languages) {
  List<Language> newList = [];
  newList = languages;
  newList.sort((a, b) {
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  });
  return newList;
}

String translateSystemLanguageByCode(String? code) {
  if (code == null) return "System language";
  String result = "System language";
  allSupportedLanguages().forEach((element) {
    if (code == element.code) result = element.systemLanguageTranslation;
  });
  return result;
}
