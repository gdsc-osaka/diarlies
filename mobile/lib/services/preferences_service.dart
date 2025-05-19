import 'package:diarlies/shared/language.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_service.g.dart';

@riverpod
Future<SharedPreferences> _sharedPreferences(Ref ref) =>
    SharedPreferences.getInstance();

@riverpod
Future<PreferencesService> preferencesService(Ref ref) async => PreferencesService(await ref.watch(_sharedPreferencesProvider.future));

@Riverpod(keepAlive: true)
Future<bool> onboardingCompleted(Ref ref) async {
  final pref = await ref.watch(preferencesServiceProvider.future);
  return pref.getOnboardingCompleted();
}

class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  // should_store_location
  static const String _shouldStoreLocationKey = 'should_store_location';

  static Future<void> setShouldStoreLocation(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_shouldStoreLocationKey, value);
  }

  static Future<bool> getShouldStoreLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_shouldStoreLocationKey) ?? false; // デフォルトはfalse
  }

  // diary_language
  static const String _diaryLanguageKey = 'diary_language';

  Future<void> setDiaryLanguage(Language value) async {
    await _prefs.setString(_diaryLanguageKey, value.name);
  }

  Language? getDiaryLanguage() {
    final val = _prefs.getString(_diaryLanguageKey);
    if (val == null) {
      return null;
    }
    return Language.values.firstWhere(
      (element) => element.name == val,
      orElse: () => Language.en,
    );
  }

  // onboarding_completed
  static const String _onboardingCompletedKey = 'onboarding_completed';

  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool(_onboardingCompletedKey, value);
  }

  bool getOnboardingCompleted() {
    return _prefs.getBool(_onboardingCompletedKey) ?? false;
  }
}
