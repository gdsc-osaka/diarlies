import 'package:api/api.dart';
import 'package:diarlies/providers/api_providers.dart';
import 'package:diarlies/shared/flux_action.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../components/nb_refresh_indicator.dart';
import '../../../i18n/strings.g.dart';
import '../../../styles/styles.dart';
import '../_components/diary_card.dart';
import '../_components/diary_display.dart';
import '_components/diary_user_suffix.dart';

part 'action.dart';

part 'providers.dart';

part 'page.g.dart';

class HomeSocialPage extends ConsumerWidget {
  const HomeSocialPage({super.key});

  static const path = '/home/social';
  static const name = 'home_social';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_homeSocialActionProvider);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(top: 64, child: Text(t.home_social.title, style: styles.text.headline.m)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NBRefreshIndicator(
            onRefresh: action.reloadTimeline,
            child: ListView.separated(
              clipBehavior: Clip.none,
              itemCount: ref.watch(diariesInTimelineProvider).maybeWhen(
                data: (diaries) => diaries.length + 2,
                orElse: () => 1,
              ),
              itemBuilder: (context, index) {
                final diaries = ref.watch(diariesInTimelineProvider).valueOrNull;
                if (index == 0 || index - 1 == diaries?.length) return SizedBox(height: 123);

                final diary = diaries?.elementAtOrNull(index - 1);

                return DiaryCard(
                  showPrevPage: false,
                  child: diary != null ? DiaryDisplay(
                    diary: diary,
                    headerSuffix: DiaryUserSuffix(
                      userName: diary.user.name,
                      userHandle: diary.user.handle,
                      iconUrl: diary.user.iconUrl,
                    ),
                  ) : const SizedBox(),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            ),
          ),
        ),
      ],
    );
  }
}
