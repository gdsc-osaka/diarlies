import 'package:diarlies/styles/color_styles.dart';
import 'package:diarlies/styles/shadow_styles.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

class Styles {
  const Styles({required this.color, required this.text, required this.shadow});

  final ColorStyles color;
  final TextStyles text;
  final ShadowStyles shadow;

  static Styles of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<StylesProvider>();
    assert(provider != null, 'No StylesProvider found in context');
    return provider!.styles;
  }

  /// Create a [Styles] instance based on the [BuildContext].
  /// This method uses Theme.of(context) to get the current theme and color scheme.
  static Styles from(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final color = switch (brightness) {
      Brightness.light => ColorStyles.light,
      Brightness.dark => ColorStyles.dark,
    };

    return Styles(color: color, text: TextStyles.from(color), shadow: ShadowStyles.from(color));
  }
}

class StylesProvider extends InheritedWidget {
  const StylesProvider({super.key, required Widget? child, required this.styles})
    : super(child: child ?? const SizedBox());

  final Styles styles;

  @override
  bool updateShouldNotify(StylesProvider oldWidget) {
    return styles != oldWidget.styles;
  }
}
