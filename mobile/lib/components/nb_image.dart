import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';

class NBImage extends StatelessWidget {
  const NBImage({super.key, required this.image, this.borderRadius = 12});

  final Image image;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: styles.color.border,
          width: 4,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      ),
    );
  }
}
