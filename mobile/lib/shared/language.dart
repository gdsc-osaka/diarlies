enum Language {
  en('🇺🇸', 'English'),
  ja('🇯🇵', '日本語'),;

  const Language(this.emoji, this.name);

  final String emoji;
  final String name;
}