import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:diarlies/styles/styles.dart';

class NBTextField extends HookWidget {
  /// テキストフィールドの最大行数。null の場合はデフォルト (通常は1行)。
  final int? maxLines;

  /// 入力フィールドが空の場合に表示されるヒントテキスト。
  final String? placeholder;

  /// テキストフィールドの先頭に表示されるアイコンウィジェット。
  final Widget? prefixIcon;

  /// テキストフィールドの現在の値。
  final String? value;

  /// テキストフィールドの値が変更されたときに呼び出されるコールバック。
  final ValueChanged<String> onChanged;

  const NBTextField({
    super.key,
    required this.value,
    required this.onChanged,
    this.maxLines,
    this.placeholder,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context); // アプリのスタイルを取得
    final controller = useTextEditingController();

    // 外部から渡される `value` プロパティの変更を監視し、
    // TextEditingController のテキストに反映します。
    // これにより、親ウィジェットからの状態変更がテキストフィールドに正しく表示されます。
    // カーソル位置は、テキスト変更時にテキストの末尾に移動します。
    useEffect(() {
      if (controller.text != value) {
        controller.value = TextEditingValue(
          text: value ?? '',
          selection: TextSelection.collapsed(offset: value?.length ?? 0),
        );
      }
      return null; // クリーンアップ関数は不要なため null を返します。
    }, [value]); // `value` が変更された場合にのみこのEffectを再実行します。

    // `onChanged` コールバックを `useCallback` でメモ化し、
    // 依存する `onChanged` プロパティが変更されない限り、関数のインスタンスを再生成しません。
    final onTextFieldChanged = useCallback((String newValue) {
      onChanged(newValue);
    }, [onChanged]);

    // NBSelect ウィジェットのボーダースタイルを参考に、共通のボーダースタイルを定義します。
    // 角は大きく丸くし（カプセル型に近い）、枠線の色と太さを指定します。
    final borderRadius = BorderRadius.circular(200.0);

    return TextFormField(
      controller: controller,
      onChanged: onTextFieldChanged,
      maxLines: maxLines,
      // テキスト入力のスタイル。NBSelect の選択中テキストスタイルを参考に設定します。
      style: styles.text.label.m.copyWith(color: styles.color.onTertiary),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: placeholder,
        // プレースホルダーのテキストスタイル。NBSelect のプレースホルダースタイルを参考に設定します。
        hintStyle: TextStyle(color: styles.color.onTertiary),
        filled: true, // 背景色を有効にします。
        fillColor: styles.color.tertiary, // NBSelect の背景色に合わせます。
        // コンテンツのパディング。NBSelect のパディングに合わせます。
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: styles.color.border, width: 4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: styles.color.border, width: 4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: styles.color.pink, width: 4.0),
        ),
        // 必要に応じて、errorBorder や focusedErrorBorder も
        // NBSelect のデザイン思想に合わせて定義することができます。
      ),
    );
  }
}
