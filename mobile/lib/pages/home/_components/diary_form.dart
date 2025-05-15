import 'dart:io';

import 'package:diarlies/components/nb_button.dart';
import 'package:diarlies/shared/types.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../components/nb_image.dart';
import '../../../components/nb_text_field.dart';
import '../../../components/variant.dart';
import '../../../i18n/strings.g.dart';
import '../../../styles/styles.dart';
import 'map.dart';

class DiaryForm extends StatelessWidget {
  const DiaryForm({super.key, required this.onAddPhotoPressed, required this.selectedPhotos, required this.memo, required this.onMemoChanged, required this.onWriteDiaryPressed});

  final FutureOrCallback onAddPhotoPressed;
  final List<File> selectedPhotos;
  final String memo;
  final ValueChanged<String> onMemoChanged;
  final FutureOrCallback onWriteDiaryPressed;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.home.label.photo, style: styles.text.title.m),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NBButton(
              onPressed: onAddPhotoPressed,
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
          initialLocation: LatLng(35.6811398, 139.7644865),
        ),
        const SizedBox(height: 16),
        Text(t.home.label.memo, style: styles.text.title.m),
        const SizedBox(height: 8),
        NBTextField(
          value: memo,
          maxLines: 2,
          placeholder: t.home.placeholder.memo,
          onChanged: onMemoChanged,
        ),
        const Expanded(child: SizedBox()),
        NBButton(label: Text(t.home.btn.keep_diary), onPressed: onWriteDiaryPressed),
      ],
    );
  }
}
