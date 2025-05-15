import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';

class NBImage extends StatelessWidget {
  const NBImage({super.key, required this.image});

  final Image image;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: styles.color.border,
          width: 4,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: image,
      ),
    );
  }
}
