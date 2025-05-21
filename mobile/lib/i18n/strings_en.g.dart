///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsSignupEn signup = TranslationsSignupEn._(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn._(_root);
	late final TranslationsOnboardingPermissionEn onboarding_permission = TranslationsOnboardingPermissionEn._(_root);
	late final TranslationsOnboardingFinishEn onboarding_finish = TranslationsOnboardingFinishEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsHomeSocialEn home_social = TranslationsHomeSocialEn._(_root);
	late final TranslationsHomeSettingsEn home_settings = TranslationsHomeSettingsEn._(_root);
}

// Path: signup
class TranslationsSignupEn {
	TranslationsSignupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get subtitle => 'A diary app with AI agent';
	late final TranslationsSignupBtnEn btn = TranslationsSignupBtnEn._(_root);
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Hi deary';
	String get subtitle => 'This is a text-free social diary app.\nBefore we begin, let’s finish the setup.';
	late final TranslationsOnboardingLabelEn label = TranslationsOnboardingLabelEn._(_root);
	late final TranslationsOnboardingPlaceholderEn placeholder = TranslationsOnboardingPlaceholderEn._(_root);
	late final TranslationsOnboardingBtnEn btn = TranslationsOnboardingBtnEn._(_root);
}

// Path: onboarding_permission
class TranslationsOnboardingPermissionEn {
	TranslationsOnboardingPermissionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Check permissions';
	String get subtitle => 'For the best app experience,\nwe\'ll need access to your personal data.';
	late final TranslationsOnboardingPermissionLabelEn label = TranslationsOnboardingPermissionLabelEn._(_root);
	late final TranslationsOnboardingPermissionDescriptionEn description = TranslationsOnboardingPermissionDescriptionEn._(_root);
	late final TranslationsOnboardingPermissionBtnEn btn = TranslationsOnboardingPermissionBtnEn._(_root);
}

// Path: onboarding_finish
class TranslationsOnboardingFinishEn {
	TranslationsOnboardingFinishEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Welcome';
	String get subtitle => 'Your AI diary assistant, Diarlies.';
	late final TranslationsOnboardingFinishBtnEn btn = TranslationsOnboardingFinishBtnEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'what happened today?';
	late final TranslationsHomeBottomNavEn bottom_nav = TranslationsHomeBottomNavEn._(_root);
	late final TranslationsHomeBtnEn btn = TranslationsHomeBtnEn._(_root);
	late final TranslationsHomeLabelEn label = TranslationsHomeLabelEn._(_root);
	late final TranslationsHomePlaceholderEn placeholder = TranslationsHomePlaceholderEn._(_root);
	late final TranslationsHomeSuccessEn success = TranslationsHomeSuccessEn._(_root);
	late final TranslationsHomeErrorEn error = TranslationsHomeErrorEn._(_root);
	late final TranslationsHomeDialogEn dialog = TranslationsHomeDialogEn._(_root);
	late final TranslationsHomeCardEn card = TranslationsHomeCardEn._(_root);
}

// Path: home_social
class TranslationsHomeSocialEn {
	TranslationsHomeSocialEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Social';
	late final TranslationsHomeSocialCardEn card = TranslationsHomeSocialCardEn._(_root);
}

// Path: home_settings
class TranslationsHomeSettingsEn {
	TranslationsHomeSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	late final TranslationsHomeSettingsBtnEn btn = TranslationsHomeSettingsBtnEn._(_root);
	late final TranslationsHomeSettingsLabelEn label = TranslationsHomeSettingsLabelEn._(_root);
	late final TranslationsHomeSettingsSelectEn select = TranslationsHomeSettingsSelectEn._(_root);
	late final TranslationsHomeSettingsSuccessEn success = TranslationsHomeSettingsSuccessEn._(_root);
	late final TranslationsHomeSettingsErrorEn error = TranslationsHomeSettingsErrorEn._(_root);
	late final TranslationsHomeSettingsDialogEn dialog = TranslationsHomeSettingsDialogEn._(_root);
}

// Path: signup.btn
class TranslationsSignupBtnEn {
	TranslationsSignupBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get google => 'Continue with Google';
	String get apple => 'Continue with Apple';
}

// Path: onboarding.label
class TranslationsOnboardingLabelEn {
	TranslationsOnboardingLabelEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get language => 'Choose diary language';
}

// Path: onboarding.placeholder
class TranslationsOnboardingPlaceholderEn {
	TranslationsOnboardingPlaceholderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get language => 'Select language';
}

// Path: onboarding.btn
class TranslationsOnboardingBtnEn {
	TranslationsOnboardingBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get next => 'Next';
}

// Path: onboarding_permission.label
class TranslationsOnboardingPermissionLabelEn {
	TranslationsOnboardingPermissionLabelEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get location => 'Background location';
	String get storage => 'Storage';
	String get notification => 'Notification';
}

// Path: onboarding_permission.description
class TranslationsOnboardingPermissionDescriptionEn {
	TranslationsOnboardingPermissionDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get location => 'To automatically create a map or timeline of places you visited today in your diary, this app collects location data in the background.';
	String get storage => 'To create diary entries using your photos, this app needs access to your photo library.';
	String get notification => 'To remind you to write your diary and show notification while tracing your location, this app needs permission to send notifications.';
}

// Path: onboarding_permission.btn
class TranslationsOnboardingPermissionBtnEn {
	TranslationsOnboardingPermissionBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get configure => 'Configure Permissions';
	String get not_now => 'Not Now';
	String get back => 'Back';
	String get next => 'Next';
}

// Path: onboarding_finish.btn
class TranslationsOnboardingFinishBtnEn {
	TranslationsOnboardingFinishBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get start => 'Start';
}

// Path: home.bottom_nav
class TranslationsHomeBottomNavEn {
	TranslationsHomeBottomNavEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get diary => 'Diary';
	String get social => 'Social';
	String get settings => 'Settings';
}

// Path: home.btn
class TranslationsHomeBtnEn {
	TranslationsHomeBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get add_photo => 'Add photo';
	String get keep_diary => 'Keep diary';
	String get retry => 'Retry';
	String get regenerate => 'Regenerate';
	String get cancel => 'Cancel';
	String get report => 'Report';
}

// Path: home.label
class TranslationsHomeLabelEn {
	TranslationsHomeLabelEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get photo => 'Today’s photos';
	String get journey => 'Today’s journey';
	String get memo => 'Memo';
}

// Path: home.placeholder
class TranslationsHomePlaceholderEn {
	TranslationsHomePlaceholderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get memo => 'Today I feel like...\nI went to...';
}

// Path: home.success
class TranslationsHomeSuccessEn {
	TranslationsHomeSuccessEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get report_diary => 'Thank you for your report.';
}

// Path: home.error
class TranslationsHomeErrorEn {
	TranslationsHomeErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get failed_to_fetch_todays_diary => 'Failed to fetch today’s diary';
}

// Path: home.dialog
class TranslationsHomeDialogEn {
	TranslationsHomeDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get regenerate_title => 'Are you sure you want to regenerate diary?';
	String get regenerate_content => 'You can’t undo this action.';
	String get report_title => 'Report inappropriate content';
	String get report_content => 'Please provide a reason for reporting this content.';
}

// Path: home.card
class TranslationsHomeCardEn {
	TranslationsHomeCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get background_location_disabled => 'Background location is disabled. We can include location changes in your diary by enabling this from the settings page.';
}

// Path: home_social.card
class TranslationsHomeSocialCardEn {
	TranslationsHomeSocialCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get diary_not_found => 'It seems like anyone hasn’t shared their diary yet.\nBe the first to share your diary by changing your account visibility to public!';
	String get diary_fetch_error => 'Woops! Something went wrong while fetching the diary.\nPlease try again later.';
}

// Path: home_settings.btn
class TranslationsHomeSettingsBtnEn {
	TranslationsHomeSettingsBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sign_out => 'Sign out';
	String get terms => 'Terms of Service';
	String get privacy => 'Privacy Policy';
	String get cancel => 'Cancel';
	String get enable_background_location => 'Enable background location';
	String get disable_background_location => 'Disable background location';
	String get delete_account => 'Delete account';
	String get privacy_policy => 'Privacy Policy';
}

// Path: home_settings.label
class TranslationsHomeSettingsLabelEn {
	TranslationsHomeSettingsLabelEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get privacy => 'Privacy';
	String get account => 'Account';
	String get additional_resources => 'Additional resources';
}

// Path: home_settings.select
class TranslationsHomeSettingsSelectEn {
	TranslationsHomeSettingsSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get public => 'Account visibility - Public';
	String get private => 'Account visibility - Private';
}

// Path: home_settings.success
class TranslationsHomeSettingsSuccessEn {
	TranslationsHomeSettingsSuccessEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get change_visibility => 'Visibility changed successfully';
	String get delete_account => 'Account deleted successfully';
	String get background_location_enabled => 'Background location enabled';
	String get background_location_disabled => 'Background location disabled';
}

// Path: home_settings.error
class TranslationsHomeSettingsErrorEn {
	TranslationsHomeSettingsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get failed_to_sign_out => 'Failed to sign out';
	String get failed_to_delete_account => 'Failed to delete account';
	String get failed_to_enable_background_location => 'Failed to enable background location';
	String get failed_to_disable_background_location => 'Failed to disable background location';
}

// Path: home_settings.dialog
class TranslationsHomeSettingsDialogEn {
	TranslationsHomeSettingsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sign_out_title => 'Are you sure you want to sign out?';
	String get delete_account_title => 'Are you sure you want to delete your account?';
	String get delete_account_content => 'This action is irreversible. All your data will be deleted.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'signup.subtitle': return 'A diary app with AI agent';
			case 'signup.btn.google': return 'Continue with Google';
			case 'signup.btn.apple': return 'Continue with Apple';
			case 'onboarding.title': return 'Hi deary';
			case 'onboarding.subtitle': return 'This is a text-free social diary app.\nBefore we begin, let’s finish the setup.';
			case 'onboarding.label.language': return 'Choose diary language';
			case 'onboarding.placeholder.language': return 'Select language';
			case 'onboarding.btn.next': return 'Next';
			case 'onboarding_permission.title': return 'Check permissions';
			case 'onboarding_permission.subtitle': return 'For the best app experience,\nwe\'ll need access to your personal data.';
			case 'onboarding_permission.label.location': return 'Background location';
			case 'onboarding_permission.label.storage': return 'Storage';
			case 'onboarding_permission.label.notification': return 'Notification';
			case 'onboarding_permission.description.location': return 'To automatically create a map or timeline of places you visited today in your diary, this app collects location data in the background.';
			case 'onboarding_permission.description.storage': return 'To create diary entries using your photos, this app needs access to your photo library.';
			case 'onboarding_permission.description.notification': return 'To remind you to write your diary and show notification while tracing your location, this app needs permission to send notifications.';
			case 'onboarding_permission.btn.configure': return 'Configure Permissions';
			case 'onboarding_permission.btn.not_now': return 'Not Now';
			case 'onboarding_permission.btn.back': return 'Back';
			case 'onboarding_permission.btn.next': return 'Next';
			case 'onboarding_finish.title': return 'Welcome';
			case 'onboarding_finish.subtitle': return 'Your AI diary assistant, Diarlies.';
			case 'onboarding_finish.btn.start': return 'Start';
			case 'home.title': return 'what happened today?';
			case 'home.bottom_nav.diary': return 'Diary';
			case 'home.bottom_nav.social': return 'Social';
			case 'home.bottom_nav.settings': return 'Settings';
			case 'home.btn.add_photo': return 'Add photo';
			case 'home.btn.keep_diary': return 'Keep diary';
			case 'home.btn.retry': return 'Retry';
			case 'home.btn.regenerate': return 'Regenerate';
			case 'home.btn.cancel': return 'Cancel';
			case 'home.btn.report': return 'Report';
			case 'home.label.photo': return 'Today’s photos';
			case 'home.label.journey': return 'Today’s journey';
			case 'home.label.memo': return 'Memo';
			case 'home.placeholder.memo': return 'Today I feel like...\nI went to...';
			case 'home.success.report_diary': return 'Thank you for your report.';
			case 'home.error.failed_to_fetch_todays_diary': return 'Failed to fetch today’s diary';
			case 'home.dialog.regenerate_title': return 'Are you sure you want to regenerate diary?';
			case 'home.dialog.regenerate_content': return 'You can’t undo this action.';
			case 'home.dialog.report_title': return 'Report inappropriate content';
			case 'home.dialog.report_content': return 'Please provide a reason for reporting this content.';
			case 'home.card.background_location_disabled': return 'Background location is disabled. We can include location changes in your diary by enabling this from the settings page.';
			case 'home_social.title': return 'Social';
			case 'home_social.card.diary_not_found': return 'It seems like anyone hasn’t shared their diary yet.\nBe the first to share your diary by changing your account visibility to public!';
			case 'home_social.card.diary_fetch_error': return 'Woops! Something went wrong while fetching the diary.\nPlease try again later.';
			case 'home_settings.title': return 'Settings';
			case 'home_settings.btn.sign_out': return 'Sign out';
			case 'home_settings.btn.terms': return 'Terms of Service';
			case 'home_settings.btn.privacy': return 'Privacy Policy';
			case 'home_settings.btn.cancel': return 'Cancel';
			case 'home_settings.btn.enable_background_location': return 'Enable background location';
			case 'home_settings.btn.disable_background_location': return 'Disable background location';
			case 'home_settings.btn.delete_account': return 'Delete account';
			case 'home_settings.btn.privacy_policy': return 'Privacy Policy';
			case 'home_settings.label.privacy': return 'Privacy';
			case 'home_settings.label.account': return 'Account';
			case 'home_settings.label.additional_resources': return 'Additional resources';
			case 'home_settings.select.public': return 'Account visibility - Public';
			case 'home_settings.select.private': return 'Account visibility - Private';
			case 'home_settings.success.change_visibility': return 'Visibility changed successfully';
			case 'home_settings.success.delete_account': return 'Account deleted successfully';
			case 'home_settings.success.background_location_enabled': return 'Background location enabled';
			case 'home_settings.success.background_location_disabled': return 'Background location disabled';
			case 'home_settings.error.failed_to_sign_out': return 'Failed to sign out';
			case 'home_settings.error.failed_to_delete_account': return 'Failed to delete account';
			case 'home_settings.error.failed_to_enable_background_location': return 'Failed to enable background location';
			case 'home_settings.error.failed_to_disable_background_location': return 'Failed to disable background location';
			case 'home_settings.dialog.sign_out_title': return 'Are you sure you want to sign out?';
			case 'home_settings.dialog.delete_account_title': return 'Are you sure you want to delete your account?';
			case 'home_settings.dialog.delete_account_content': return 'This action is irreversible. All your data will be deleted.';
			default: return null;
		}
	}
}

