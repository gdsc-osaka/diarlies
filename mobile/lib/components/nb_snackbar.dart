import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:async';

// flutter_hooksをインポート

enum SnackBarType { error, success, info }

// NBSnackBar Widget (HookWidget)
class NBSnackBar extends HookWidget {
  final String title;
  final SnackBarType type;
  final VoidCallback onDismissed; // Dismissibleが発火したときに外部でOverlayEntryをremoveするためのコールバック
  final ValueNotifier<bool> isVisibleNotifier; // 表示状態を外部から制御

  const NBSnackBar({
    super.key,
    required this.title,
    required this.type,
    required this.onDismissed,
    required this.isVisibleNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    const animationDuration = Duration(milliseconds: 300);
    final snackBarHeight = useState<double>(100.0); // 仮の初期高さ

    // isVisibleNotifierの値が変更されたときにアニメーションを実行
    final isVisible = useValueListenable(isVisibleNotifier);

    // スナックバーの高さを動的に取得するためのGlobalKey
    final GlobalKey containerKey = useMemoized(() => GlobalKey(), []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (containerKey.currentContext != null) {
          final RenderBox? renderBox = containerKey.currentContext!.findRenderObject() as RenderBox?;
          if (renderBox != null && context.mounted) {
            snackBarHeight.value = renderBox.size.height;
          }
        }
      });
      return null; // クリーンアップ関数なし
    }, [isVisible]); // isVisibleが変更された時（特に最初に表示された時）に高さを再計算する可能性も考慮

    final topPosition = isVisible ? 16.0 : -(snackBarHeight.value + 16.0) - 100;

    return AnimatedPositioned(
      duration: animationDuration,
      curve: Curves.easeInOut,
      top: topPosition,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Dismissible(
          direction: DismissDirection.up,
          key: ValueKey(title), // ValueKey(key) でも良いが、コンテンツに基づく方が一般的
          onDismissed: (direction) {
            onDismissed(); // 外部のリムーブ処理を呼び出す
          },
          child: Container(
            key: containerKey, // 高さを取得するためのキー
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: switch (type) {
                SnackBarType.error => styles.color.error,
                SnackBarType.success => styles.color.greenPastel,
                SnackBarType.info => styles.color.tertiary,
              },
              boxShadow: [styles.shadow.medium],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: styles.color.border, width: 4),
            ),
            child: DefaultTextStyle(
              style: styles.text.body.m.copyWith(
                color: switch (type) {
                  SnackBarType.error => styles.color.onError,
                  SnackBarType.success => styles.color.onGreenPastel,
                  SnackBarType.info => styles.color.onTertiary,
                },
                fontWeight: FontWeight.bold,
              ),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}

void showNBSnackBar(BuildContext context, {String? title, SnackBarType type = SnackBarType.info}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  const animationDuration = Duration(milliseconds: 300);
  const displayDuration = Duration(seconds: 5);

  // ValueNotifierを使用してNBSnackBarの表示状態を制御
  final isVisibleNotifier = ValueNotifier<bool>(false);

  // OverlayEntryを削除し、Notifierを破棄する関数
  void removeOverlayEntry() {
    if (overlayEntry.mounted) {
      // mounted プロパティはOverlayEntryには直接ないため、フラグ管理するかtry-catchが適切
      try {
        overlayEntry.remove();
      } catch (e) {
        // すでに削除されている場合など
        // print("Error removing overlay entry: $e");
      }
    }
    isVisibleNotifier.dispose(); // ValueNotifierを破棄
  }

  // アニメーション付きで非表示にし、その後OverlayEntryを削除する関数
  void hideAndRemoveSnackBar() {
    if (!isVisibleNotifier.value) return; // すでに非表示処理中の場合は何もしない

    isVisibleNotifier.value = false; // スライドアウトアニメーションを開始
    Timer(animationDuration, () {
      removeOverlayEntry();
    });
  }

  overlayEntry = OverlayEntry(
    builder:
        (context) => NBSnackBar(
          title: title ?? 'Notification', // nullの場合はデフォルトタイトル
          type: type,
          isVisibleNotifier: isVisibleNotifier,
          onDismissed: () {
            // Dismissibleによってスワイプされた場合も、アニメーション付きで非表示
            hideAndRemoveSnackBar();
          },
        ),
  );

  overlay.insert(overlayEntry);

  // 遅延後に表示アニメーションを開始
  WidgetsBinding.instance.addPostFrameCallback((_) {
    isVisibleNotifier.value = true; // スライドインアニメーションを開始
  });

  // 一定時間後に自動で非表示
  Timer(displayDuration, () {
    hideAndRemoveSnackBar();
  });
}
