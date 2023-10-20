part 'data/en.dart';
part 'data/fr.dart';
part 'data/ja.dart';
part 'data/ko.dart';
part 'data/vi.dart';
part 'data/zh.dart';

class Language {
  late Map<String, String> _localizedStrings = {};

  Future<void> setupData(String? langCode) async {
    switch (langCode) {
      case "fr":
        _localizedStrings = fr;
        return;
      case "ja":
        _localizedStrings = ja;
        return;
      case "ko":
        _localizedStrings = ko;
        return;
      case "vi":
        _localizedStrings = vi;
        return;
      case "zh":
        _localizedStrings = zh;
        return;
      default:
        _localizedStrings = en;
    }
  }

  String key(String key) => _localizedStrings[key] ?? key;
}
