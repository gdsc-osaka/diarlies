import 'package:diarlies/providers/auth_providers.dart';
import 'package:diarlies/styles/color_styles.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i18n/strings.g.dart';
import 'initialize.dart';
import 'providers/firebase_providers.dart';
import 'router.dart';
import 'styles/theme.dart';

void main() {
  runApp(TranslationProvider(child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    initializeApp().then((succeeded) async {
      if (!succeeded) return;

      ref.invalidate(authProvider);
      ref.invalidate(analyticsProvider);
      ref.invalidate(messagingProvider);

      ref.invalidate(currentUserProvider);
    });

    return MaterialApp.router(
      title: 'Diarlies',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      // theme
      theme: themeFromColorStyle(ColorStyles.light),
      darkTheme: themeFromColorStyle(ColorStyles.dark),
      themeMode: ThemeMode.system,
      // l10n
      locale: TranslationProvider.of(context).flutterLocale, // use provider
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => primaryFocus?.unfocus(),
          child: StylesProvider(styles: Styles.from(context), child: child),
        );
      },
    );
  }
}
