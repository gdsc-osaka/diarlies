import 'package:diarlies/components/nb_card.dart';
import 'package:diarlies/pages/onboarding/_components/onboarding_positioned.dart';
import 'package:diarlies/pages/onboarding/permission/page.dart';
import 'package:diarlies/providers/permission_providers.dart';
import 'package:diarlies/router.dart';
import 'package:diarlies/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../components/images.dart';
import '../../components/nb_button.dart';
import '../../components/nb_select.dart';
import '../../i18n/strings.g.dart';
import '../../services/permission_service.dart';
import '../../shared/flux_action.dart';
import '../../shared/language.dart';
import '../../styles/styles.dart';
import 'finish/page.dart';

part 'action.dart';

part 'providers.dart';

part 'page.g.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  static const path = '/onboarding';
  static const name = 'Onboarding';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_onboardingActionProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(alignment: Alignment.center, child: ImageAdapter(image: Images.book, size: Size(220, 220))),
            OnboardingPositioned(
              child: Column(
                children: [
                  Text(t.onboarding.title, style: styles.text.display.m),
                  const SizedBox(height: 16),
                  Text(
                    t.onboarding.subtitle,
                    style: styles.text.title.m.copyWith(height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Offstage()),
                  NBCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(t.onboarding.label.language, style: styles.text.title.m),
                        const SizedBox(height: 12),
                        NBSelect(
                          placeholder: t.onboarding.placeholder.language,
                          onChanged: action.setLanguage,
                          value: ref.watch(diaryLanguageProvider).valueOrNull,
                          values: [Language.ja, Language.en],
                          builder: (Language language) {
                            return Row(
                              children: [
                                Text(language.emoji),
                                const SizedBox(width: 8),
                                Text(language.name, style: styles.text.body.m),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        NBButton(
                          label: Text(t.onboarding.btn.next),
                          onPressed: ref.watch(diaryLanguageProvider).valueOrNull == null ? null : action.next,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
