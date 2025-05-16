import 'package:flutter/material.dart';

import '../../../../components/nb_image.dart';
import '../../../../styles/styles.dart';

class DiaryUserSuffix extends StatelessWidget {
  const DiaryUserSuffix({super.key, this.iconUrl, required this.userName, required this.userHandle});

  final String? iconUrl;
  final String userHandle;
  final String userName;
  
  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (iconUrl != null)
          NBImage(
            image: Image.network(iconUrl!, width: 40, height: 40),
          ),
        if (iconUrl == null)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: styles.color.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.person, color: styles.color.onPrimary),
          ),
        const SizedBox(height: 4),
        Text(
          userName,
          style: styles.text.title.m,
        ),
        Text(
          userHandle,
          style: styles.text.body.s.copyWith(color: styles.color.outline),
        ),
      ],
    );
  }
}
