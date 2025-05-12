import 'package:diarlies/components/nb_card.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // 隣のページ
            Positioned(
              left: -constraints.maxWidth + 6,
              top: 0,
              width: constraints.maxWidth,
              child: AspectRatio(aspectRatio: 0.75, child: NBCard(color: styles.color.paper)),
            ),
            // 本体
            AspectRatio(
              aspectRatio: 0.75,
              child: NBCard(color: styles.color.paper, padding: EdgeInsets.all(20), child: child),
            ),
            // 左側のリング
            Positioned(
              left: -12,
              top: 100,
              bottom: 100,
              width: 30,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(5, (i) => _DiaryRing(width: 30)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DiaryRing extends StatelessWidget {
  const _DiaryRing({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(decoration: BoxDecoration(color: styles.color.border, borderRadius: BorderRadius.circular(20))),
    );
  }
}
