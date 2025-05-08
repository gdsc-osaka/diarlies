import 'package:flutter/material.dart';

import '../styles/styles.dart';

class NBSelect<T> extends StatelessWidget {
  /// 現在選択されている値。null の場合はプレースホルダーが表示されます。
  final T? value;

  /// 選択されていない場合に表示されるテキスト。
  final String? placeholder;

  /// 値が変更されたときに呼び出されるコールバック。
  final ValueChanged<T?>? onChanged;

  /// ドロップダウンに表示される値のリスト。
  final List<T> values;

  /// 各値を表示するための Widget を構築する関数。
  /// Select 本体の選択中表示とドロップダウンメニュー内の項目表示の両方に使用されます。
  final Widget Function(T value) builder;

  const NBSelect({
    super.key,
    required this.values,
    required this.builder,
    this.value,
    this.placeholder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context); // アプリのスタイルを取得

    // 共通のボーダースタイルを定義
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(200.0), // 完全な円形
      borderSide: BorderSide(color: styles.color.border, width: 4.0),
    );

    return DropdownButtonFormField<T>(
      value: value,
      items:
          values.map((val) {
            // ドロップダウンメニューの各項目を生成
            return DropdownMenuItem<T>(
              value: val,
              // builder 関数で各項目の Widget を構築
              child: DefaultTextStyle(style: styles.text.label.m, child: builder(val)),
            );
          }).toList(),
      onChanged: onChanged,
      hint:
          placeholder != null
              ? Text(
                placeholder!,
                // プレースホルダーの文字色を設定
                style: TextStyle(color: styles.color.onTertiary),
              )
              : null,
      // 右端のアイコン
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      iconEnabledColor: styles.color.onTertiary,
      dropdownColor: styles.color.tertiary,
      // ドロップダウンメニューの角丸
      borderRadius: BorderRadius.circular(20.0),
      isExpanded: true,
      // 横幅いっぱいに広げる
      // DropdownButtonFormField の装飾
      decoration: InputDecoration(
        // 背景色を有効にする
        filled: true,
        fillColor: styles.color.tertiary,
        // Select 本体の背景色
        // コンテンツのパディング (見た目を調整)
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        // ボーダースタイルを適用
        border: borderStyle,
        enabledBorder: borderStyle,
        // 通常時のボーダー
        focusedBorder: borderStyle, // フォーカス時のボーダー (同じスタイルを適用)
        // エラー時などの他のボーダースタイルも必要に応じて追加できます
        // errorBorder: ...,
        // focusedErrorBorder: ...,
      ),
      // Select 本体の文字色やスタイル。
      // builder が Text ウィジェットを返す場合、ここで指定したスタイルが適用されることが多い。
      // builder が複雑な Widget を返す場合は、builder 内で色を指定する必要があるかもしれません。
      style: styles.text.label.m.copyWith(color: styles.color.onTertiary),
    );
  }
}
