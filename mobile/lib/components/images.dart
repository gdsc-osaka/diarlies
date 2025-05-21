import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Images {
  book('assets/images/book.svg', AssetType.svg),
  shapeCircleGreen('assets/images/shape_circle_green.svg', AssetType.svg),
  shapeTrianglePink('assets/images/shape_triangle_pink.svg', AssetType.svg),
  shapeHexagonBlue('assets/images/shape_hexagon_blue.svg', AssetType.svg),
  shapeStickPurple('assets/images/shape_stick_purple.svg', AssetType.svg);

  const Images(this.path, this.type);

  final String path;
  final AssetType type;
}

enum AssetType { svg, png }

class ImageAdapter extends StatelessWidget {
  const ImageAdapter({super.key, required this.image, required this.size});

  final Images image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return switch (image.type) {
      AssetType.svg => SvgPicture.asset(image.path, width: size.width, height: size.height, fit: BoxFit.cover),
      AssetType.png => Image.asset(image.path, width: size.width, height: size.height),
    };
  }
}
