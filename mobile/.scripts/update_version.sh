#!/bin/bash

path_to_pubspec="../pubspec.yaml"

# Gitリポジトリのルートディレクトリに移動 (必要に応じて)
# cd /path/to/your/repo

echo "Finding latest tag..."

# 最新のタグを取得 (アノテーション付きタグ、軽量タグの両方を探す)
# --tags: 軽量タグも考慮する
# --abbrev=0: ハッシュを省略して完全なタグ名を取得
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null)

# git describe コマンドの終了ステータスを確認
if [ $? -ne 0 ]; then
  echo "Error: No Git tags found. Please check if there are any tags in the repository."
  exit 0
fi

echo "Latest tag: $latest_tag"

# タグ名からバージョン番号とビルド番号を抽出
# 想定される形式: <prefix>-<version>+<build> (例: myapp-1.0.0+1)

# 正規表現でマッチング (Bash 3.0以降)
# [[ string =~ regex ]]
if [[ "$latest_tag" =~ ^(.*)-([0-9]+\.[0-9]+\.[0-9]+)\+([0-9]+)$ ]]; then
  # マッチした部分を取得 (BASH_REMATCH配列)
  # BASH_REMATCH[0] は全体のマッチ
  # BASH_REMATCH[1] は最初のキャプチャグループ (<prefix>)
  # BASH_REMATCH[2] は2番目のキャプチャグループ (<version>)
  # BASH_REMATCH[3] は3番目のキャプチャグループ (<build>)
  tag_prefix="${BASH_REMATCH[1]}"
  version_number="${BASH_REMATCH[2]}"
  build_number="${BASH_REMATCH[3]}"

  echo "  Prefix: $tag_prefix"
  echo "  Version number: $version_number"
  echo "  Build number: $build_number"

  old_version=$(awk '/^version:/ {print $2}' $path_to_pubspec)
  new_version="$version_number+$((build_number))"

  echo "Setting pubspec.yaml version $old_version to $new_version"
  if [[ "$OSTYPE" == "darwin"* ]]; then
      # macOS sed (requires a space after -i)
      sed -i '' -e "s/version: $old_version/version: $new_version/g" $path_to_pubspec
  else
      # GNU sed (requires no space after -i)
      sed -i'' -e "s/version: $old_version/version: $new_version/g" $path_to_pubspec
  fi
else
  echo "Error: Tag '$latest_tag' does not match the expected format (<prefix>-<version>+<build>)."
  exit 0
fi

echo "Version updated successfully in pubspec.yaml"
exit 0