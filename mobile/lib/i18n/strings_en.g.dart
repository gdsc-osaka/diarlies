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
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
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
	late final TranslationsHomeErrorEn error = TranslationsHomeErrorEn._(_root);
	late final TranslationsHomeDialogEn dialog = TranslationsHomeDialogEn._(_root);
}

// Path: home_social
class TranslationsHomeSocialEn {
	TranslationsHomeSocialEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Social';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	late final TranslationsSettingsBtnEn btn = TranslationsSettingsBtnEn._(_root);
	late final TranslationsSettingsLabelEn label = TranslationsSettingsLabelEn._(_root);
	late final TranslationsSettingsSelectEn select = TranslationsSettingsSelectEn._(_root);
	late final TranslationsSettingsSuccessEn success = TranslationsSettingsSuccessEn._(_root);
	late final TranslationsSettingsErrorEn error = TranslationsSettingsErrorEn._(_root);
	late final TranslationsSettingsDialogEn dialog = TranslationsSettingsDialogEn._(_root);
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
	String get memo => 'Today I feel like...';
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
}

// Path: settings.btn
class TranslationsSettingsBtnEn {
	TranslationsSettingsBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sign_out => 'Sign out';
	String get terms => 'Terms of Service';
	String get privacy => 'Privacy Policy';
	String get cancel => 'Cancel';
}

// Path: settings.label
class TranslationsSettingsLabelEn {
	TranslationsSettingsLabelEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get visibility => 'Account visibility';
}

// Path: settings.select
class TranslationsSettingsSelectEn {
	TranslationsSettingsSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get public => 'Public';
	String get private => 'Private';
}

// Path: settings.success
class TranslationsSettingsSuccessEn {
	TranslationsSettingsSuccessEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get change_visibility => 'Visibility changed successfully';
}

// Path: settings.error
class TranslationsSettingsErrorEn {
	TranslationsSettingsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get failed_to_sign_out => 'Failed to sign out';
}

// Path: settings.dialog
class TranslationsSettingsDialogEn {
	TranslationsSettingsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sign_out_title => 'Are you sure you want to sign out?';
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
			case 'home.label.photo': return 'Today’s photos';
			case 'home.label.journey': return 'Today’s journey';
			case 'home.label.memo': return 'Memo';
			case 'home.placeholder.memo': return 'Today I feel like...';
			case 'home.error.failed_to_fetch_todays_diary': return 'Failed to fetch today’s diary';
			case 'home.dialog.regenerate_title': return 'Are you sure you want to regenerate diary?';
			case 'home.dialog.regenerate_content': return 'You can’t undo this action.';
			case 'home_social.title': return 'Social';
			case 'settings.title': return 'Settings';
			case 'settings.btn.sign_out': return 'Sign out';
			case 'settings.btn.terms': return 'Terms of Service';
			case 'settings.btn.privacy': return 'Privacy Policy';
			case 'settings.btn.cancel': return 'Cancel';
			case 'settings.label.visibility': return 'Account visibility';
			case 'settings.select.public': return 'Public';
			case 'settings.select.private': return 'Private';
			case 'settings.success.change_visibility': return 'Visibility changed successfully';
			case 'settings.error.failed_to_sign_out': return 'Failed to sign out';
			case 'settings.dialog.sign_out_title': return 'Are you sure you want to sign out?';
			default: return null;
		}
	}
}

