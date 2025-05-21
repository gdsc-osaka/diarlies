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
	@override late final _TranslationsHomeSettingsJa home_settings = _TranslationsHomeSettingsJa._(_root);
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
	@override late final _TranslationsHomeSuccessJa success = _TranslationsHomeSuccessJa._(_root);
	@override late final _TranslationsHomeErrorJa error = _TranslationsHomeErrorJa._(_root);
	@override late final _TranslationsHomeDialogJa dialog = _TranslationsHomeDialogJa._(_root);
	@override late final _TranslationsHomeCardJa card = _TranslationsHomeCardJa._(_root);
}

// Path: home_social
class _TranslationsHomeSocialJa implements TranslationsHomeSocialEn {
	_TranslationsHomeSocialJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ソーシャル';
	@override late final _TranslationsHomeSocialCardJa card = _TranslationsHomeSocialCardJa._(_root);
}

// Path: home_settings
class _TranslationsHomeSettingsJa implements TranslationsHomeSettingsEn {
	_TranslationsHomeSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '設定';
	@override late final _TranslationsHomeSettingsBtnJa btn = _TranslationsHomeSettingsBtnJa._(_root);
	@override late final _TranslationsHomeSettingsLabelJa label = _TranslationsHomeSettingsLabelJa._(_root);
	@override late final _TranslationsHomeSettingsSelectJa select = _TranslationsHomeSettingsSelectJa._(_root);
	@override late final _TranslationsHomeSettingsSuccessJa success = _TranslationsHomeSettingsSuccessJa._(_root);
	@override late final _TranslationsHomeSettingsErrorJa error = _TranslationsHomeSettingsErrorJa._(_root);
	@override late final _TranslationsHomeSettingsDialogJa dialog = _TranslationsHomeSettingsDialogJa._(_root);
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
	@override String get report => '報告';
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

// Path: home.success
class _TranslationsHomeSuccessJa implements TranslationsHomeSuccessEn {
	_TranslationsHomeSuccessJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get report_diary => 'ご報告ありがとうございます。';
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
	@override String get report_title => '不適切なコンテンツを報告';
	@override String get report_content => 'このコンテンツを報告する理由を教えてください。';
}

// Path: home.card
class _TranslationsHomeCardJa implements TranslationsHomeCardEn {
	_TranslationsHomeCardJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get background_location_disabled => 'バックグラウンド位置情報が無効になっています。\n設定ページからこれを有効にすることで、日記に位置情報の変更を含めることができます。';
}

// Path: home_social.card
class _TranslationsHomeSocialCardJa implements TranslationsHomeSocialCardEn {
	_TranslationsHomeSocialCardJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get diary_not_found => 'まだ誰も日記を共有していないようです。\nアカウントの公開範囲を公開に変更して、最初の日記を共有しましょう！';
	@override String get diary_fetch_error => 'おっと！日記の取得中に問題が発生しました。\nしばらく待ってからもう一度お試しください。';
}

// Path: home_settings.btn
class _TranslationsHomeSettingsBtnJa implements TranslationsHomeSettingsBtnEn {
	_TranslationsHomeSettingsBtnJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sign_out => 'サインアウト';
	@override String get terms => '利用規約';
	@override String get privacy => 'プライバシーポリシー';
	@override String get cancel => 'キャンセル';
	@override String get enable_background_location => 'バックグラウンド位置情報を有効にする';
	@override String get disable_background_location => 'バックグラウンド位置情報を無効にする';
	@override String get delete_account => 'アカウントを削除';
	@override String get privacy_policy => 'プライバシーポリシー';
}

// Path: home_settings.label
class _TranslationsHomeSettingsLabelJa implements TranslationsHomeSettingsLabelEn {
	_TranslationsHomeSettingsLabelJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get privacy => 'プライバシー';
	@override String get account => 'アカウント';
	@override String get additional_resources => 'その他のリソース';
}

// Path: home_settings.select
class _TranslationsHomeSettingsSelectJa implements TranslationsHomeSettingsSelectEn {
	_TranslationsHomeSettingsSelectJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get public => 'アカウントの公開範囲 - 公開';
	@override String get private => 'アカウントの公開範囲 - 非公開';
}

// Path: home_settings.success
class _TranslationsHomeSettingsSuccessJa implements TranslationsHomeSettingsSuccessEn {
	_TranslationsHomeSettingsSuccessJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get change_visibility => '公開範囲が変更されました';
	@override String get delete_account => 'アカウントが削除されました';
	@override String get background_location_enabled => 'バックグラウンド位置情報が有効になりました';
	@override String get background_location_disabled => 'バックグラウンド位置情報が無効になりました';
}

// Path: home_settings.error
class _TranslationsHomeSettingsErrorJa implements TranslationsHomeSettingsErrorEn {
	_TranslationsHomeSettingsErrorJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get failed_to_sign_out => 'サインアウトに失敗しました';
	@override String get failed_to_delete_account => 'アカウントの削除に失敗しました';
	@override String get failed_to_enable_background_location => 'バックグラウンド位置情報の有効化に失敗しました';
	@override String get failed_to_disable_background_location => 'バックグラウンド位置情報の無効化に失敗しました';
}

// Path: home_settings.dialog
class _TranslationsHomeSettingsDialogJa implements TranslationsHomeSettingsDialogEn {
	_TranslationsHomeSettingsDialogJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get sign_out_title => 'ログアウトしますか？';
	@override String get delete_account_title => 'アカウントを削除しますか？';
	@override String get delete_account_content => 'この操作は元に戻せません。アカウントを削除すると、すべてのデータが失われます。';
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
			case 'home.btn.report': return '報告';
			case 'home.label.photo': return '今日の写真';
			case 'home.label.journey': return '今日の旅路';
			case 'home.label.memo': return 'メモ';
			case 'home.placeholder.memo': return '今日の気分は...';
			case 'home.success.report_diary': return 'ご報告ありがとうございます。';
			case 'home.error.failed_to_fetch_todays_diary': return '今日の日記の取得に失敗しました';
			case 'home.dialog.regenerate_title': return '日記を再生成してもよろしいですか？';
			case 'home.dialog.regenerate_content': return 'この操作は元に戻せません。';
			case 'home.dialog.report_title': return '不適切なコンテンツを報告';
			case 'home.dialog.report_content': return 'このコンテンツを報告する理由を教えてください。';
			case 'home.card.background_location_disabled': return 'バックグラウンド位置情報が無効になっています。\n設定ページからこれを有効にすることで、日記に位置情報の変更を含めることができます。';
			case 'home_social.title': return 'ソーシャル';
			case 'home_social.card.diary_not_found': return 'まだ誰も日記を共有していないようです。\nアカウントの公開範囲を公開に変更して、最初の日記を共有しましょう！';
			case 'home_social.card.diary_fetch_error': return 'おっと！日記の取得中に問題が発生しました。\nしばらく待ってからもう一度お試しください。';
			case 'home_settings.title': return '設定';
			case 'home_settings.btn.sign_out': return 'サインアウト';
			case 'home_settings.btn.terms': return '利用規約';
			case 'home_settings.btn.privacy': return 'プライバシーポリシー';
			case 'home_settings.btn.cancel': return 'キャンセル';
			case 'home_settings.btn.enable_background_location': return 'バックグラウンド位置情報を有効にする';
			case 'home_settings.btn.disable_background_location': return 'バックグラウンド位置情報を無効にする';
			case 'home_settings.btn.delete_account': return 'アカウントを削除';
			case 'home_settings.btn.privacy_policy': return 'プライバシーポリシー';
			case 'home_settings.label.privacy': return 'プライバシー';
			case 'home_settings.label.account': return 'アカウント';
			case 'home_settings.label.additional_resources': return 'その他のリソース';
			case 'home_settings.select.public': return 'アカウントの公開範囲 - 公開';
			case 'home_settings.select.private': return 'アカウントの公開範囲 - 非公開';
			case 'home_settings.success.change_visibility': return '公開範囲が変更されました';
			case 'home_settings.success.delete_account': return 'アカウントが削除されました';
			case 'home_settings.success.background_location_enabled': return 'バックグラウンド位置情報が有効になりました';
			case 'home_settings.success.background_location_disabled': return 'バックグラウンド位置情報が無効になりました';
			case 'home_settings.error.failed_to_sign_out': return 'サインアウトに失敗しました';
			case 'home_settings.error.failed_to_delete_account': return 'アカウントの削除に失敗しました';
			case 'home_settings.error.failed_to_enable_background_location': return 'バックグラウンド位置情報の有効化に失敗しました';
			case 'home_settings.error.failed_to_disable_background_location': return 'バックグラウンド位置情報の無効化に失敗しました';
			case 'home_settings.dialog.sign_out_title': return 'ログアウトしますか？';
			case 'home_settings.dialog.delete_account_title': return 'アカウントを削除しますか？';
			case 'home_settings.dialog.delete_account_content': return 'この操作は元に戻せません。アカウントを削除すると、すべてのデータが失われます。';
			default: return null;
		}
	}
}

