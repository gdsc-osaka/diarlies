import 'dart:async';

import 'package:diarlies/components/variant.dart';
import 'package:diarlies/shared/color_utils.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NBButton<T> extends HookWidget {
  const NBButton({
    super.key,
    required this.label,
    this.variant = Variant.primary,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.mainAxisSize = MainAxisSize.max,
    this.direction = Axis.horizontal,
  });

  final Widget label;
  final Variant variant;
  final FutureOr<T> Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? icon;
  final MainAxisSize mainAxisSize;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);
    final isLoading = useState(false);
    final styles = Styles.of(context);

    final effectiveBgColor = switch (variant) {
      Variant.primary => backgroundColor ?? styles.color.primary,
      Variant.secondary => backgroundColor ?? styles.color.secondary,
    };
    final effectiveFgColor = switch (variant) {
      Variant.primary => foregroundColor ?? styles.color.onPrimary,
      Variant.secondary => foregroundColor ?? styles.color.onSecondary,
    };

    final borderColor = styles.color.border;
    final shadowColor = styles.color.border;
    final borderRadius = BorderRadius.circular(16.0);
    final shadowOffset = styles.shadow.low.offset;

    final disabled = onPressed == null;
    final pressedBgColor = darkenColor(effectiveBgColor, lightnessFactor: 0.08, saturationFactor: 0.05);
    final positionOffset = (disabled || isPressed.value) ? shadowOffset : Offset.zero;
    final currentBgColor =
        disabled
            ? styles.color.disabled
            : isPressed.value
            ? pressedBgColor
            : effectiveBgColor;
    final canInteract = !isLoading.value || disabled;

    final handlePressed = useCallback(() async {
      if (isLoading.value) return;

      isLoading.value = true;
      try {
        final result = onPressed?.call();
        if (result is Future) {
          await result;
        }
      } finally {
        isLoading.value = false;
      }
    }, [isLoading, onPressed]);

    final onTapDown = useCallback((TapDownDetails details) {
      if (canInteract) {
        isPressed.value = true;
      }
    }, [canInteract, isPressed]);

    final onTapUp = useCallback((TapUpDetails details) {
      if (isPressed.value) {
        isPressed.value = false;
        handlePressed();
      }
    }, [isPressed, handlePressed]);

    final onTapCancel = useCallback(() {
      if (isPressed.value) {
        isPressed.value = false;
      }
    }, [isPressed]);

    Widget buildButtonContent(Styles styles, Color fgColor, {required bool isLoadingOverride}) {
      final labelWidget = DefaultTextStyle(style: styles.text.label.m.copyWith(color: effectiveFgColor), child: label);

      return switch (direction) {
        Axis.horizontal => Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoadingOverride) ...[SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(fgColor)),
            ), const SizedBox(width: 8.0)],
            if (!isLoadingOverride && icon != null) ...[
              SizedBox(
                width: 20,
                height: 20,
                child: IconTheme(data: IconThemeData(color: effectiveFgColor, size: 20), child: icon!),
              ),
              const SizedBox(width: 8.0),
            ],
            labelWidget,
          ],
        ),
        Axis.vertical => Column(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isLoadingOverride && icon != null) ...[
              IconTheme(data: IconThemeData(color: effectiveFgColor, size: 32), child: icon!),
              const SizedBox(height: 12.0),
            ],
            if (isLoadingOverride) ...[SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(fgColor)),
            ), const SizedBox(height: 12.0)],
            labelWidget,
          ],
        ),
      };
    }

    final padding = EdgeInsets.only(left: icon == null ? 14 : 18, right: 18.0, top: 12.0, bottom: 12.0);

    return GestureDetector(
      onTapDown: canInteract ? onTapDown : null,
      onTapUp: canInteract ? onTapUp : null,
      onTapCancel: canInteract ? onTapCancel : null,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // shadow
          Padding(
            padding: EdgeInsets.only(top: shadowOffset.dy, left: shadowOffset.dx),
            child: Container(
              decoration: BoxDecoration(
                color: shadowColor,
                border: Border.all(color: shadowColor, width: 4.0),
                borderRadius: borderRadius,
              ),
              padding: padding,
              child: buildButtonContent(styles, effectiveFgColor, isLoadingOverride: isLoading.value),
            ),
          ),
          // Button Body
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.fastOutSlowIn,
            transform: Matrix4.translationValues(positionOffset.dx, positionOffset.dy, 0),
            decoration: BoxDecoration(
              color: isLoading.value ? effectiveBgColor.withValues(alpha: 0.7) : currentBgColor,
              border: Border.all(color: borderColor, width: 4.0),
              borderRadius: borderRadius,
            ),
            padding: padding,
            child: buildButtonContent(styles, effectiveFgColor, isLoadingOverride: isLoading.value),
          ),
        ],
      ),
    );
  }
}
