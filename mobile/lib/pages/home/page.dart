import 'dart:io';

import 'package:api/api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:diarlies/components/nb_button.dart';
import 'package:diarlies/components/nb_card.dart';
import 'package:diarlies/components/nb_dialog.dart';
import 'package:diarlies/components/nb_snackbar.dart';
import 'package:diarlies/components/variant.dart';
import 'package:diarlies/i18n/strings.g.dart';
import 'package:diarlies/logger.dart';
import 'package:diarlies/pages/home/_components/diary_card.dart';
import 'package:diarlies/pages/home/_components/diary_display.dart';
import 'package:diarlies/pages/home/_components/diary_form.dart';
import 'package:diarlies/pages/onboarding/page.dart';
import 'package:diarlies/providers/api_providers.dart';
import 'package:diarlies/providers/auth_providers.dart';
import 'package:diarlies/providers/location_providers.dart';
import 'package:diarlies/services/api_adapter.dart';
import 'package:diarlies/shared/error_handler.dart';
import 'package:diarlies/shared/flux_action.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'action.dart';

part 'page.g.dart';

part 'providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const path = '/home';
  static const name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Styles.of(context);
    final action = ref.watch(_homeActionProvider);

    final selectedPhotos = ref.watch(selectedPhotosProvider);

    handleWriteDiary() async {
      await action.writeDiary(
        errorHandler: (message) {
          showNBSnackBar(context, title: message, type: SnackBarType.error);
        },
      );
    }

    handleRegenerate(Diary diary) {
      showDialog(
        context: context,
        builder:
            (context) => NBDialog(
              title: Text(t.home.dialog.regenerate_title),
              content: Text(t.home.dialog.regenerate_content),
              actions: [
                NBButton(
                  label: Text(t.home.btn.cancel),
                  variant: Variant.secondary,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                NBButton(
                  label: Text(t.home.btn.regenerate),
                  onPressed: () async {
                    await action.deleteDiary(
                      diary,
                      errorHandler: (message) {
                        showNBSnackBar(context, title: message, type: SnackBarType.error);
                      },
                    );

                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(top: 64, child: Text(t.home.title, style: styles.text.headline.m)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DiaryCard(
            child: ref
                .watch(todaysDiaryProvider)
                .when(
                  data:
                      (diary) =>
                          diary == null
                              ? DiaryForm(
                                onAddPhotoPressed: action.addPhoto,
                                selectedPhotos: selectedPhotos,
                                memo: ref.watch(diaryMemoProvider) ?? '',
                                onMemoChanged: action.updateMemo,
                                onWriteDiaryPressed: handleWriteDiary,
                              )
                              : DiaryDisplay(diary: diary,
                          headerSuffix: NBButton(label: Text(t.home.btn.regenerate),
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => handleRegenerate(diary), variant: Variant.secondary),
                          ),
                  error:
                      (e, s) => NBCard(
                        color: styles.color.error,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.home.error.failed_to_fetch_todays_diary,
                              style: styles.text.title.m.copyWith(color: styles.color.onError),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              e is ServiceError ? '[${e.code}] ${e.message}' : e.toString(),
                              style: styles.text.body.m.copyWith(color: styles.color.onError),
                            ),
                            Expanded(child: SizedBox()),
                            NBButton(
                              label: Text(t.home.btn.retry),
                              variant: Variant.secondary,
                              onPressed: action.retryFetchDiary,
                            ),
                          ],
                        ),
                      ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
          ),
        ),
      ],
    );
  }
}
