import 'package:diarlies/components/variant.dart';
import 'package:diarlies/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../components/nb_button.dart';
import '../../../components/nb_card.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/flux_action.dart';
import '../../../styles/styles.dart';
import '_components/permission_section.dart';

part 'action.dart';

part 'page.g.dart';

class OnboardingPermissionPage extends ConsumerWidget {
  const OnboardingPermissionPage({super.key});

  static const path = 'permission';
  static const name = 'onboarding_permission';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_onboardingPermissionActionProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 120,
              bottom: 80,
              child: Column(
                children: [
                  Text(t.onboarding_permission.title, style: styles.text.display.s),
                  const SizedBox(height: 16),
                  Text(
                    t.onboarding_permission.subtitle,
                    style: styles.text.title.m.copyWith(height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Offstage()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: NBCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PermissionSection(
                            title: t.onboarding_permission.label.location,
                            description: t.onboarding_permission.description.location,
                            icon: Icon(Icons.location_on_outlined),
                            color: styles.color.greenHalfTone,
                            enabled: true,
                          ),
                          const SizedBox(height: 12),
                          PermissionSection(
                            title: t.onboarding_permission.label.storage,
                            description: t.onboarding_permission.description.storage,
                            icon: Icon(Icons.insert_drive_file_outlined),
                            color: styles.color.blueHalfTone,
                            enabled: true,
                          ),
                          const SizedBox(height: 20),
                          NBButton(label: Text(t.onboarding_permission.btn.configure), onPressed: action.finish),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(child: NBButton(label: Text(t.onboarding_permission.btn.back), onPressed: action.back, variant: Variant.secondary)),
                              const SizedBox(width: 8),
                              Expanded(child: NBButton(label: Text(t.onboarding_permission.btn.not_now), onPressed: action.finish, variant: Variant.secondary)),
                            ],
                          ),
                        ],
                      ),
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
