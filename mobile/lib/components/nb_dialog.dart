import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';

class NBDialog extends StatelessWidget {
  const NBDialog({super.key, required this.title, this.content, required this.actions});

  final Widget title;
  final Widget? content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: styles.color.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: styles.color.border, width: 4),
          boxShadow: [styles.shadow.medium],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle(style: styles.text.title.l, child: title),
            const SizedBox(height: 16),
            if (content != null) ...[
              DefaultTextStyle(style: styles.text.body.m, child: content!),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
                  actions.map((action) {
                    return Padding(padding: const EdgeInsets.only(left: 8.0), child: action);
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
