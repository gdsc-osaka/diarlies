import 'package:diarlies/components/nb_button.dart';
import 'package:diarlies/components/nb_card.dart';
import 'package:diarlies/components/nb_dialog.dart';
import 'package:diarlies/components/variant.dart';
import 'package:diarlies/i18n/strings.g.dart';
import 'package:diarlies/providers/auth_providers.dart';
import 'package:diarlies/providers/firebase_providers.dart';
import 'package:diarlies/shared/flux_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../styles/styles.dart';

part 'action.dart';

part 'page.g.dart';

class HomeSettingsPage extends ConsumerWidget {
  const HomeSettingsPage({super.key});

  static const path = '/home/settings';
  static const name = 'home_settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_homeSettingsActionProvider);

    handleSignOut() {
      showDialog(
        context: context,
        builder:
            (context) => NBDialog(
              title: Text(t.settings.dialog.sign_out_title),
              actions: [
                NBButton(
                  label: Text(t.settings.btn.cancel),
                  variant: Variant.secondary,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                NBButton(
                  label: Text(t.settings.btn.sign_out),
                  onPressed: () async {
                    await action.signOut();
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NBCard(
            child: Column(
              children: [
                Text(t.settings.title, style: styles.text.headline.m),
                const SizedBox(height: 16),
                NBButton(
                  label: Text(t.settings.btn.sign_out),
                  icon: const Icon(Icons.logout),
                  variant: Variant.secondary,
                  onPressed: handleSignOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
