import 'package:api/api.dart';
import 'package:diarlies/components/nb_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../styles/styles.dart';

class DiaryDisplay extends StatelessWidget {
  const DiaryDisplay({super.key, required this.diary, this.headerSuffix});

  final Diary diary;
  final Widget? headerSuffix;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final diaryDate = DateTime(diary.diaryDate.year, diary.diaryDate.month, diary.diaryDate.day);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(diary.diaryDate.day.toString().padLeft(2, '0'), style: styles.text.display.l),
                Container(
                  width: 70,
                  height: 4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: styles.color.border),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.yM(languageCode).format(diaryDate),
                  style: styles.text.title.m.copyWith(fontSize: styles.text.title.m.fontSize! + 2),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            if (headerSuffix != null) headerSuffix!,
          ],
        ),
        Expanded(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              // bounds は ShaderMask の子ウィジェットの描画範囲です
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent, // 上端を透明に
                  Colors.white, // 少し下から不透明に
                  Colors.white, // 中央部分は不透明
                  Colors.transparent, // 下端を透明に
                ],
                stops: [0.0, 0.1, 0.9, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Stack(
                  children: [
                    Positioned(
                      top: 13,
                      child: Column(
                        children: List.generate(
                          50,
                          (i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: 300,
                              height: 2,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(color: styles.color.border.withValues(alpha: 0.4)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(diary.content, style: styles.text.handwriting.m),
                  ],
                ),
              ),
            ),
          ),
        ),
        NBImage(image: Image.network(diary.thumbnailUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 130,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: double.infinity,
              height: 130,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(color: styles.color.surface),
              ),
            );
          },
        ))
      ],
    );
  }
}
