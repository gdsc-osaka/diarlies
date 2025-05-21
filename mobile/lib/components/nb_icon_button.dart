import 'dart:async';

import 'package:diarlies/components/variant.dart';
import 'package:diarlies/shared/color_utils.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NBIconButton<T> extends HookWidget {
  const NBIconButton({
    super.key,
    required this.icon,
    this.variant = Variant.primary,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(10.0),
  });

  final Widget icon;
  final Variant variant;
  final FutureOr<T> Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;
  final double iconSize;
  final EdgeInsetsGeometry padding;

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
      if (isLoading.value || onPressed == null) return;

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

    Widget buildButtonContent(Color fgColor, {required bool isLoadingOverride}) {
      if (isLoadingOverride) {
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: CircularProgressIndicator(strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(fgColor)),
        );
      } else {
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: IconTheme(data: IconThemeData(color: effectiveFgColor, size: iconSize), child: icon),
        );
      }
    }

    Widget buttonCore = GestureDetector(
      onTapDown: canInteract ? onTapDown : null,
      onTapUp: canInteract ? onTapUp : null,
      onTapCancel: canInteract ? onTapCancel : null,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Shadow
          Padding(
            // Offsetを2倍しないと影がズレる
            padding: EdgeInsets.only(top: shadowOffset.dy * 2, left: shadowOffset.dx * 2),
            child: Container(
                decoration: BoxDecoration(
                  color: shadowColor,
                  border: Border.all(color: shadowColor, width: 4.0),
                  borderRadius: borderRadius,
                ),
                padding: padding,
                child: Opacity(
                  opacity: 0,
                  child: buildButtonContent(effectiveFgColor, isLoadingOverride: isLoading.value),
                )
            ),
          ),
          // Actual button
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
            child: buildButtonContent(effectiveFgColor, isLoadingOverride: isLoading.value),
          ),
        ],
      ),
    );

    if (tooltip != null && !disabled) {
      return Tooltip(
        message: tooltip!,
        child: buttonCore,
      );
    }

    return buttonCore;
  }
}
