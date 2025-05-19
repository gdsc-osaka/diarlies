import 'package:diarlies/components/nb_button.dart';
import 'package:diarlies/components/nb_card.dart';
import 'package:diarlies/i18n/strings.g.dart';
import 'package:diarlies/pages/home/page.dart';
import 'package:diarlies/pages/onboarding/_components/onboarding_positioned.dart';
import 'package:diarlies/router.dart';
import 'package:diarlies/services/preferences_service.dart';
import 'package:diarlies/shared/flux_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../components/images.dart';
import '../../../styles/styles.dart';

part 'action.dart';

part 'page.g.dart';

class OnboardingFinishPage extends ConsumerWidget {
  const OnboardingFinishPage({super.key});

  static const path = 'finish';
  static const name = 'onboarding_finish';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_onboardingFinishActionProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(alignment: Alignment.center, child: ImageAdapter(image: Images.book, size: Size(220, 220))),
            OnboardingPositioned(
              child: Column(
                children: [
                  Text(t.onboarding_finish.title, style: styles.text.display.m),
                  const SizedBox(height: 16),
                  Text(
                    t.onboarding_finish.subtitle,
                    style: styles.text.title.m,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Offstage()),
                  NBCard(child: NBButton(label: Text(t.onboarding_finish.btn.start), onPressed: action.start)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
