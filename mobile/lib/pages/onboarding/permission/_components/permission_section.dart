import 'package:flutter/material.dart';

import '../../../../styles/styles.dart';

class PermissionSection extends StatelessWidget {
  const PermissionSection({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.enabled,
  });

  final String title;
  final String description;
  final Widget icon;
  final Color color;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: enabled ? color : styles.color.tertiary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: styles.color.border, width: 2),
          ),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 200),
          child: icon,
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: styles.text.title.m,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: styles.text.body.m,
              ),
            ],
          ),
        )
      ],
    );
  }
}
