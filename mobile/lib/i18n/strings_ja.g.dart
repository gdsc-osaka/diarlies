///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsJa implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsSignupJa signup = _TranslationsSignupJa._(_root);
	@override late final _TranslationsOnboardingJa onboarding = _TranslationsOnboardingJa._(_root);
	@override late final _TranslationsOnboardingPermissionJa onboarding_permission = _TranslationsOnboardingPermissionJa._(_root);
}

// Path: signup
class _TranslationsSignupJa implements TranslationsSignupEn {
	_TranslationsSignupJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'AIエージェントを搭載した日記アプリ';
	@override late final _TranslationsSignupBtnJa btn = _TranslationsSignupBtnJa._(_root);
}

// Path: onboarding
class _TranslationsOnboardingJa implements TranslationsOnboardingEn {
	_TranslationsOnboardingJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'こんにちは';
	@override String get subtitle => 'Diarliesはテキストフリーのソーシャル日記アプリです。\n始める前に、セットアップを完了させましょう。';
	@override late final _TranslationsOnboardingLabelJa label = _TranslationsOnboardingLabelJa._(_root);
	@override late final _TranslationsOnboardingPlaceholderJa placeholder = _TranslationsOnboardingPlaceholderJa._(_root);
	@override late final _TranslationsOnboardingBtnJa btn = _TranslationsOnboardingBtnJa._(_root);
}

// Path: onboarding_permission
class _TranslationsOnboardingPermissionJa implements TranslationsOnboardingPermissionEn {
	_TranslationsOnboardingPermissionJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '権限を確認';
	@override String get subtitle => '最高のアプリ体験のために、\n個人データへのアクセスが必要です。';
	@override late final _TranslationsOnboardingPermissionLabelJa label = _TranslationsOnboardingPermissionLabelJa._(_root);
	@override late final _TranslationsOnboardingPermissionDescriptionJa description = _TranslationsOnboardingPermissionDescriptionJa._(_root);
	@override late final _TranslationsOnboardingPermissionBtnJa btn = _TranslationsOnboardingPermissionBtnJa._(_root);
}

// Path: signup.btn
class _TranslationsSignupBtnJa implements TranslationsSignupBtnEn {
	_TranslationsSignupBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get google => 'Googleで続ける';
	@override String get apple => 'Appleで続ける';
}

// Path: onboarding.label
class _TranslationsOnboardingLabelJa implements TranslationsOnboardingLabelEn {
	_TranslationsOnboardingLabelJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get language => '日記の言語を選択';
}

// Path: onboarding.placeholder
class _TranslationsOnboardingPlaceholderJa implements TranslationsOnboardingPlaceholderEn {
	_TranslationsOnboardingPlaceholderJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get language => '言語を選択してください';
}

// Path: onboarding.btn
class _TranslationsOnboardingBtnJa implements TranslationsOnboardingBtnEn {
	_TranslationsOnboardingBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get next => '次へ';
}

// Path: onboarding_permission.label
class _TranslationsOnboardingPermissionLabelJa implements TranslationsOnboardingPermissionLabelEn {
	_TranslationsOnboardingPermissionLabelJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get location => 'バックグラウンド位置情報';
	@override String get storage => 'ストレージ';
}

// Path: onboarding_permission.description
class _TranslationsOnboardingPermissionDescriptionJa implements TranslationsOnboardingPermissionDescriptionEn {
	_TranslationsOnboardingPermissionDescriptionJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get location => '今日訪れた場所の地図やタイムラインを自動的に作成するために、\nこのアプリはバックグラウンドで位置情報データを収集します。';
	@override String get storage => '写真ライブラリへのアクセスが必要です。\n日記のエントリーを写真を使って作成するために、\nこのアプリはあなたの写真ライブラリへのアクセスが必要です。';
}

// Path: onboarding_permission.btn
class _TranslationsOnboardingPermissionBtnJa implements TranslationsOnboardingPermissionBtnEn {
	_TranslationsOnboardingPermissionBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get configure => '権限を設定';
	@override String get not_now => '今はやめておく';
	@override String get back => '戻る';
	@override String get finish => '完了';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'signup.subtitle': return 'AIエージェントを搭載した日記アプリ';
			case 'signup.btn.google': return 'Googleで続ける';
			case 'signup.btn.apple': return 'Appleで続ける';
			case 'onboarding.title': return 'こんにちは';
			case 'onboarding.subtitle': return 'Diarliesはテキストフリーのソーシャル日記アプリです。\n始める前に、セットアップを完了させましょう。';
			case 'onboarding.label.language': return '日記の言語を選択';
			case 'onboarding.placeholder.language': return '言語を選択してください';
			case 'onboarding.btn.next': return '次へ';
			case 'onboarding_permission.title': return '権限を確認';
			case 'onboarding_permission.subtitle': return '最高のアプリ体験のために、\n個人データへのアクセスが必要です。';
			case 'onboarding_permission.label.location': return 'バックグラウンド位置情報';
			case 'onboarding_permission.label.storage': return 'ストレージ';
			case 'onboarding_permission.description.location': return '今日訪れた場所の地図やタイムラインを自動的に作成するために、\nこのアプリはバックグラウンドで位置情報データを収集します。';
			case 'onboarding_permission.description.storage': return '写真ライブラリへのアクセスが必要です。\n日記のエントリーを写真を使って作成するために、\nこのアプリはあなたの写真ライブラリへのアクセスが必要です。';
			case 'onboarding_permission.btn.configure': return '権限を設定';
			case 'onboarding_permission.btn.not_now': return '今はやめておく';
			case 'onboarding_permission.btn.back': return '戻る';
			case 'onboarding_permission.btn.finish': return '完了';
			default: return null;
		}
	}
}

