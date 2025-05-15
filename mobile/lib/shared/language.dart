import 'package:api/api.dart';

enum Language {
  en('🇺🇸', 'English', LanguageCode.en),
  ja('🇯🇵', '日本語', LanguageCode.ja);

  const Language(this.emoji, this.name, this.code);

  final String emoji;
  final String name;
  final LanguageCode code;
}
