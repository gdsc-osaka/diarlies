import 'package:diarlies/components/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NBCircle extends StatelessWidget {
  const NBCircle({super.key, this.size = 300});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageAdapter(image: Images.shapeCircleGreen, size: Size.square(size));
  }
}

class NBTriangle extends StatelessWidget {
  const NBTriangle({super.key, this.size = 160});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageAdapter(image: Images.shapeTrianglePink, size: Size.square(size));

    /* Enable animation after fixing the bug that causes unnecessary clipping of the triangle
    final animation = useAnimationController(vsync: useSingleTickerProvider(), duration: const Duration(seconds: 10))
      ..repeat();

    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Transform.rotate(angle: animation.value * 2 * 3.14, child: child);
      },
      child: ImageAdapter(image: Images.shapeTrianglePink, size: Size.square(size)),
    );
     */
  }
}

class NBHexagon extends StatelessWidget {
  const NBHexagon({super.key, this.size = 300});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageAdapter(image: Images.shapeHexagonBlue, size: Size.square(size));
  }
}

class NBStick extends StatelessWidget {
  const NBStick({super.key, this.size = 150});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageAdapter(image: Images.shapeStickPurple, size: Size.square(size));
  }
}
