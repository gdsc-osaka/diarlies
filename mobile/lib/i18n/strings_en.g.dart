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
}

// Path: onboarding_permission.description
class TranslationsOnboardingPermissionDescriptionEn {
	TranslationsOnboardingPermissionDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get location => 'To automatically create a map or timeline of places you visited today in your diary, this app collects location data in the background.';
	String get storage => 'To create diary entries using your photos, this app needs access to your photo library.';
}

// Path: onboarding_permission.btn
class TranslationsOnboardingPermissionBtnEn {
	TranslationsOnboardingPermissionBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get configure => 'Configure Permissions';
	String get not_now => 'Not Now';
	String get back => 'Back';
	String get finish => 'Finish';
}

// Path: onboarding_finish.btn
class TranslationsOnboardingFinishBtnEn {
	TranslationsOnboardingFinishBtnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get start => 'Start';
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
			case 'onboarding_permission.description.location': return 'To automatically create a map or timeline of places you visited today in your diary, this app collects location data in the background.';
			case 'onboarding_permission.description.storage': return 'To create diary entries using your photos, this app needs access to your photo library.';
			case 'onboarding_permission.btn.configure': return 'Configure Permissions';
			case 'onboarding_permission.btn.not_now': return 'Not Now';
			case 'onboarding_permission.btn.back': return 'Back';
			case 'onboarding_permission.btn.finish': return 'Finish';
			case 'onboarding_finish.title': return 'Welcome';
			case 'onboarding_finish.subtitle': return 'Your AI diary assistant, Diarlies.';
			case 'onboarding_finish.btn.start': return 'Start';
			default: return null;
		}
	}
}

