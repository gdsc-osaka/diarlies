import 'package:api/api.dart';
import 'package:built_value/serializer.dart';
import 'package:diarlies/pages/_components/app_icon.dart';
import 'package:diarlies/providers/api_providers.dart';
import 'package:diarlies/providers/auth_providers.dart';
import 'package:diarlies/providers/firebase_providers.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:diarlies/styles/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../components/icon.dart';
import '../../components/nb_button.dart';
import '../../components/nb_card.dart';
import '../../i18n/strings.g.dart';
import '../../logger.dart';
import '../../shared/flux_action.dart';

part 'action.dart';
part 'page.g.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  static const path = '/signup';
  static const name = 'signup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_signupActionProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 140),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppIcon(size: 128, type: AppIconType.splash),
              const SizedBox(height: 16),
              Text('Diarlies', style: styles.text.display.m),
              const SizedBox(height: 8),
              Text(
                t.signup.subtitle,
                style: styles.text.display.m.copyWith(
                  fontFamily: Fonts.lexendGiga.name,
                  fontSize: styles.text.body.m.fontSize,
                ),
              ),
              const SizedBox(height: 48),
              NBCard(
                child: Column(
                  children: [
                    NBButton(
                      label: Text(t.signup.btn.google),
                      icon: GoogleIcon(),
                      backgroundColor: styles.color.googleButton,
                      foregroundColor: styles.color.onGoogleButton,
                      mainAxisSize: MainAxisSize.max,
                      onPressed: action.signInWithGoogle,
                    ),
                    const SizedBox(height: 16),
                    NBButton(
                      label: Text(t.signup.btn.apple),
                      icon: AppleIcon(),
                      backgroundColor: styles.color.appleButton,
                      foregroundColor: styles.color.onAppleButton,
                      mainAxisSize: MainAxisSize.max,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
