import 'dart:io';

import 'package:api/api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:diarlies/components/nb_button.dart';
import 'package:diarlies/components/nb_image.dart';
import 'package:diarlies/components/nb_snackbar.dart';
import 'package:diarlies/components/nb_text_field.dart';
import 'package:diarlies/components/variant.dart';
import 'package:diarlies/i18n/strings.g.dart';
import 'package:diarlies/logger.dart';
import 'package:diarlies/pages/home/_components/diary_card.dart';
import 'package:diarlies/pages/onboarding/page.dart';
import 'package:diarlies/providers/api_providers.dart';
import 'package:diarlies/providers/location_providers.dart';
import 'package:diarlies/services/api_adapter.dart';
import 'package:diarlies/shared/error_handler.dart';
import 'package:diarlies/shared/flux_action.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '_components/map.dart';

part 'action.dart';

part 'providers.dart';

part 'page.g.dart';

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
      await action.writeDiary(errorHandler: (message) {
        showNBSnackBar(context, title: message, type: SnackBarType.error);
      });
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(top: 64, child: Text(t.home.title, style: styles.text.headline.m)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DiaryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.home.label.photo, style: styles.text.title.m),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NBButton(
                      onPressed: action.addPhoto,
                      direction: Axis.vertical,
                      variant: Variant.secondary,
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text(t.home.btn.add_photo),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 180,
                      height: 100,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 3.0,
                          childAspectRatio: 9/16,
                        ),
                        itemCount: selectedPhotos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return NBImage(
                            image: Image.file(
                              selectedPhotos[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(t.home.label.journey, style: styles.text.title.m),
                const SizedBox(height: 8),
                JourneyMap(
                  initialLocation: LatLng(135, 75),
                ),
                const SizedBox(height: 16),
                Text(t.home.label.memo, style: styles.text.title.m),
                const SizedBox(height: 8),
                NBTextField(
                  value: ref.watch(diaryMemoProvider),
                  maxLines: 2,
                  placeholder: t.home.placeholder.memo,
                  onChanged: action.updateMemo,
                ),
                const Expanded(child: SizedBox()),
                NBButton(label: Text(t.home.btn.keep_diary), onPressed: handleWriteDiary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
