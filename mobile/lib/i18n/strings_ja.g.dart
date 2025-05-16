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
	@override late final _TranslationsOnboardingFinishJa onboarding_finish = _TranslationsOnboardingFinishJa._(_root);
	@override late final _TranslationsHomeJa home = _TranslationsHomeJa._(_root);
	@override late final _TranslationsHomeSocialJa home_social = _TranslationsHomeSocialJa._(_root);
	@override late final _TranslationsSettingsJa settings = _TranslationsSettingsJa._(_root);
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

// Path: onboarding_finish
class _TranslationsOnboardingFinishJa implements TranslationsOnboardingFinishEn {
	_TranslationsOnboardingFinishJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ようこそ';
	@override String get subtitle => 'あなたのAI日記アシスタント、Diarlies。';
	@override late final _TranslationsOnboardingFinishBtnJa btn = _TranslationsOnboardingFinishBtnJa._(_root);
}

// Path: home
class _TranslationsHomeJa implements TranslationsHomeEn {
	_TranslationsHomeJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '今日は何がありましたか？';
	@override late final _TranslationsHomeBottomNavJa bottom_nav = _TranslationsHomeBottomNavJa._(_root);
	@override late final _TranslationsHomeBtnJa btn = _TranslationsHomeBtnJa._(_root);
	@override late final _TranslationsHomeLabelJa label = _TranslationsHomeLabelJa._(_root);
	@override late final _TranslationsHomePlaceholderJa placeholder = _TranslationsHomePlaceholderJa._(_root);
	@override late final _TranslationsHomeErrorJa error = _TranslationsHomeErrorJa._(_root);
	@override late final _TranslationsHomeDialogJa dialog = _TranslationsHomeDialogJa._(_root);
}

// Path: home_social
class _TranslationsHomeSocialJa implements TranslationsHomeSocialEn {
	_TranslationsHomeSocialJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ソーシャル';
}

// Path: settings
class _TranslationsSettingsJa implements TranslationsSettingsEn {
	_TranslationsSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '設定';
	@override late final _TranslationsSettingsBtnJa btn = _TranslationsSettingsBtnJa._(_root);
	@override late final _TranslationsSettingsLabelJa label = _TranslationsSettingsLabelJa._(_root);
	@override late final _TranslationsSettingsSelectJa select = _TranslationsSettingsSelectJa._(_root);
	@override late final _TranslationsSettingsSuccessJa success = _TranslationsSettingsSuccessJa._(_root);
	@override late final _TranslationsSettingsErrorJa error = _TranslationsSettingsErrorJa._(_root);
	@override late final _TranslationsSettingsDialogJa dialog = _TranslationsSettingsDialogJa._(_root);
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
	@override String get notification => '通知';
}

// Path: onboarding_permission.description
class _TranslationsOnboardingPermissionDescriptionJa implements TranslationsOnboardingPermissionDescriptionEn {
	_TranslationsOnboardingPermissionDescriptionJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get location => '今日訪れた場所の地図やタイムラインを自動的に作成するために、このアプリはバックグラウンドで位置情報データを収集します。';
	@override String get storage => '写真ライブラリへのアクセスが必要です。日記のエントリーを写真を使って作成するために、このアプリはあなたの写真ライブラリへのアクセスが必要です。';
	@override String get notification => '日記を書くリマインダーや、位置情報を追跡している間の通知を表示するために、このアプリは通知を送信する権限が必要です。';
}

// Path: onboarding_permission.btn
class _TranslationsOnboardingPermissionBtnJa implements TranslationsOnboardingPermissionBtnEn {
	_TranslationsOnboardingPermissionBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get configure => '権限を設定';
	@override String get not_now => '今はやめておく';
	@override String get back => '戻る';
	@override String get next => '次へ';
}

// Path: onboarding_finish.btn
class _TranslationsOnboardingFinishBtnJa implements TranslationsOnboardingFinishBtnEn {
	_TranslationsOnboardingFinishBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get start => 'はじめる';
}

// Path: home.bottom_nav
class _TranslationsHomeBottomNavJa implements TranslationsHomeBottomNavEn {
	_TranslationsHomeBottomNavJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get diary => '日記';
	@override String get social => 'ソーシャル';
	@override String get settings => '設定';
}

// Path: home.btn
class _TranslationsHomeBtnJa implements TranslationsHomeBtnEn {
	_TranslationsHomeBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get add_photo => '写真を追加';
	@override String get keep_diary => '日記をつける';
	@override String get retry => '再試行';
	@override String get regenerate => '再生成';
	@override String get cancel => 'キャンセル';
}

// Path: home.label
class _TranslationsHomeLabelJa implements TranslationsHomeLabelEn {
	_TranslationsHomeLabelJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get photo => '今日の写真';
	@override String get journey => '今日の旅路';
	@override String get memo => 'メモ';
}

// Path: home.placeholder
class _TranslationsHomePlaceholderJa implements TranslationsHomePlaceholderEn {
	_TranslationsHomePlaceholderJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get memo => '今日の気分は...';
}

// Path: home.error
class _TranslationsHomeErrorJa implements TranslationsHomeErrorEn {
	_TranslationsHomeErrorJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get failed_to_fetch_todays_diary => '今日の日記の取得に失敗しました';
}

// Path: home.dialog
class _TranslationsHomeDialogJa implements TranslationsHomeDialogEn {
	_TranslationsHomeDialogJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get regenerate_title => '日記を再生成してもよろしいですか？';
	@override String get regenerate_content => 'この操作は元に戻せません。';
}

// Path: settings.btn
class _TranslationsSettingsBtnJa implements TranslationsSettingsBtnEn {
	_TranslationsSettingsBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sign_out => 'サインアウト';
	@override String get terms => '利用規約';
	@override String get privacy => 'プライバシーポリシー';
	@override String get cancel => 'キャンセル';
}

// Path: settings.label
class _TranslationsSettingsLabelJa implements TranslationsSettingsLabelEn {
	_TranslationsSettingsLabelJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get visibility => 'アカウントの公開範囲';
}

// Path: settings.select
class _TranslationsSettingsSelectJa implements TranslationsSettingsSelectEn {
	_TranslationsSettingsSelectJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get public => '公開';
	@override String get private => '非公開';
}

// Path: settings.success
class _TranslationsSettingsSuccessJa implements TranslationsSettingsSuccessEn {
	_TranslationsSettingsSuccessJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get change_visibility => '公開範囲が正常に変更されました';
}

// Path: settings.error
class _TranslationsSettingsErrorJa implements TranslationsSettingsErrorEn {
	_TranslationsSettingsErrorJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get failed_to_sign_out => 'サインアウトに失敗しました';
}

// Path: settings.dialog
class _TranslationsSettingsDialogJa implements TranslationsSettingsDialogEn {
	_TranslationsSettingsDialogJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sign_out_title => 'ログアウトしますか？';
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
			case 'onboarding_permission.label.notification': return '通知';
			case 'onboarding_permission.description.location': return '今日訪れた場所の地図やタイムラインを自動的に作成するために、このアプリはバックグラウンドで位置情報データを収集します。';
			case 'onboarding_permission.description.storage': return '写真ライブラリへのアクセスが必要です。日記のエントリーを写真を使って作成するために、このアプリはあなたの写真ライブラリへのアクセスが必要です。';
			case 'onboarding_permission.description.notification': return '日記を書くリマインダーや、位置情報を追跡している間の通知を表示するために、このアプリは通知を送信する権限が必要です。';
			case 'onboarding_permission.btn.configure': return '権限を設定';
			case 'onboarding_permission.btn.not_now': return '今はやめておく';
			case 'onboarding_permission.btn.back': return '戻る';
			case 'onboarding_permission.btn.next': return '次へ';
			case 'onboarding_finish.title': return 'ようこそ';
			case 'onboarding_finish.subtitle': return 'あなたのAI日記アシスタント、Diarlies。';
			case 'onboarding_finish.btn.start': return 'はじめる';
			case 'home.title': return '今日は何がありましたか？';
			case 'home.bottom_nav.diary': return '日記';
			case 'home.bottom_nav.social': return 'ソーシャル';
			case 'home.bottom_nav.settings': return '設定';
			case 'home.btn.add_photo': return '写真を追加';
			case 'home.btn.keep_diary': return '日記をつける';
			case 'home.btn.retry': return '再試行';
			case 'home.btn.regenerate': return '再生成';
			case 'home.btn.cancel': return 'キャンセル';
			case 'home.label.photo': return '今日の写真';
			case 'home.label.journey': return '今日の旅路';
			case 'home.label.memo': return 'メモ';
			case 'home.placeholder.memo': return '今日の気分は...';
			case 'home.error.failed_to_fetch_todays_diary': return '今日の日記の取得に失敗しました';
			case 'home.dialog.regenerate_title': return '日記を再生成してもよろしいですか？';
			case 'home.dialog.regenerate_content': return 'この操作は元に戻せません。';
			case 'home_social.title': return 'ソーシャル';
			case 'settings.title': return '設定';
			case 'settings.btn.sign_out': return 'サインアウト';
			case 'settings.btn.terms': return '利用規約';
			case 'settings.btn.privacy': return 'プライバシーポリシー';
			case 'settings.btn.cancel': return 'キャンセル';
			case 'settings.label.visibility': return 'アカウントの公開範囲';
			case 'settings.select.public': return '公開';
			case 'settings.select.private': return '非公開';
			case 'settings.success.change_visibility': return '公開範囲が正常に変更されました';
			case 'settings.error.failed_to_sign_out': return 'サインアウトに失敗しました';
			case 'settings.dialog.sign_out_title': return 'ログアウトしますか？';
			default: return null;
		}
	}
}

