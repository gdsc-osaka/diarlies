import 'package:api/api.dart';
import 'package:diarlies/components/nb_card.dart';
import 'package:diarlies/logger.dart';
import 'package:diarlies/pages/home/settings/page.dart';
import 'package:diarlies/providers/api_providers.dart';
import 'package:diarlies/shared/flux_action.dart';
import 'package:diarlies/shared/serialize.dart';
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
                orElse: () => 2,
              ),
              itemBuilder: (context, index) {
                final diaries = ref.watch(diariesInTimelineProvider);
                final diariesVal = diaries.valueOrNull;

                if (diaries.isLoading && index == 1) {
                  return const SizedBox(
                    height: 123,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (diaries.hasValue && diariesVal?.isEmpty == true && index == 1) {
                  return NBCard(
                    child: Text(t.home_social.card.diary_not_found, style: styles.text.title.m),
                  );
                }

                if (diaries.hasError && index == 1) {
                  return NBCard(
                    color: styles.color.error,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.home_social.card.diary_fetch_error, style: styles.text.title.m.copyWith(color: styles.color.onError)),
                        const SizedBox(height: 8),
                        Text(
                          diaries.error.toString(),
                          style: styles.text.body.l.copyWith(color: styles.color.onError),
                        ),
                      ],
                    ),
                  );
                }

                if (index == 0 || index - 1 == diariesVal?.length) return SizedBox(height: 123);

                final diary = diariesVal?.elementAtOrNull(index - 1);

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
