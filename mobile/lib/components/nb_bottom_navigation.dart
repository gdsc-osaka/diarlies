import 'package:diarlies/shared/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:diarlies/styles/styles.dart';

class NBBottomNavigation extends StatelessWidget {
  const NBBottomNavigation({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    required this.items,
  }) : assert(items.length >= 2, "NBBottomNavigation requires at least 2 items");

  final int? currentIndex;
  final ValueChanged<int>? onTap;
  final List<NBBottomNavigationItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: _NBBottomNavigationTile(
                label: item.label,
                icon: item.icon,
                backgroundColor: item.backgroundColor,
                selected: currentIndex == index,
                onTap: () {
                  onTap?.call(index);
                },
                toolTip: item.toolTip,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NBBottomNavigationItem {
  const NBBottomNavigationItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    this.toolTip,
  });

  final Widget icon;
  final String label;
  final Color backgroundColor;
  final String? toolTip;
}

class _NBBottomNavigationTile extends HookWidget {
  const _NBBottomNavigationTile({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.selected,
    this.onTap,
    this.toolTip,
  });

  final String label;
  final Widget icon;
  final Color backgroundColor;
  final bool selected;
  final VoidCallback? onTap;
  final String? toolTip;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    final isPressed = useState(false); // タップ中の押下状態を管理

    final effectiveBgColor = backgroundColor;
    final effectiveFgColor = styles.color.onSurface;
    final disabled = onTap == null;

    // NBButtonのisPressed時や、このタイルのselected/isPressed時のハイライト色
    final highlightedBgColor = darkenColor(effectiveBgColor, lightnessFactor: switch (styles.brightness) {
      Brightness.light => 0.2,
      Brightness.dark => 0.1,
    }, saturationFactor: switch (styles.brightness) {
      Brightness.light => 0.3,
      Brightness.dark => 0.2,
    });

    final currentBgColor = switch (false) {
      false when disabled => styles.color.disabled,
      false when isPressed.value => highlightedBgColor,
      false when selected => highlightedBgColor,
      false || true => effectiveBgColor,
    };
    final currentFgColor = switch (false) {
      false when disabled => styles.color.onDisabled,
      false when isPressed.value => styles.color.onDisabled,
      false when selected => styles.color.onDisabled,
      false || true => effectiveFgColor,
    };

    // 押下中または選択中はタイルを沈ませる
    final positionOffset = (disabled)
        ? Offset.zero
        : (isPressed.value || selected)
        ? styles.shadow.low.offset
        : Offset.zero;

    Widget buildTileContent() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: IconTheme(
              data: IconThemeData(color: currentFgColor, size: 24),
              child: icon,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: styles.text.label.m.copyWith(color: currentFgColor),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    final tileContent = buildTileContent();
    final padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0);
    final borderRadius = BorderRadius.circular(16.0);

    final tileWidget = Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(top: styles.shadow.low.offset.dy, left: styles.shadow.low.offset.dx),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: styles.color.border,
              border: Border.all(color: styles.color.border, width: 4.0),
              borderRadius: borderRadius,
            ),
            padding: padding,
            child: Opacity(opacity: 0, child: tileContent),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
          transform: Matrix4.translationValues(positionOffset.dx, positionOffset.dy, 0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: currentBgColor,
            border: Border.all(color: styles.color.border, width: 4.0),
            borderRadius: borderRadius,
          ),
          padding: padding,
          child: tileContent,
        ),
      ],
    );

    return GestureDetector(
      onTapDown: disabled ? null : (_) => isPressed.value = true,
      onTapUp: disabled ? null : (_) {
        isPressed.value = false;
        onTap?.call();
      },
      onTapCancel: disabled ? null : () => isPressed.value = false,
      child: toolTip != null && toolTip!.isNotEmpty
          ? Tooltip(
        message: toolTip!,
        preferBelow: false,
        child: tileWidget,
      )
          : tileWidget,
    );
  }
}
