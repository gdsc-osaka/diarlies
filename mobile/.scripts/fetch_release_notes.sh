#!/bin/bash

# --- 設定 ---
set -e
set -o pipefail

echo "INFO: 多言語対応GitHubリリースノート取得スクリプトを開始します..."

# --- 環境変数のチェック ---
if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "エラー: 環境変数 GITHUB_TOKEN が設定されていません。"
  exit 1
fi
if [[ -z "$CM_TAG" ]]; then
  echo "エラー: 環境変数 CM_TAG が設定されていません。タグビルドで実行してください。"
  exit 1
fi
TAG_NAME="$CM_TAG"
echo "INFO: 対象タグ: $TAG_NAME"

if [[ -z "$CM_REPO_SLUG" ]]; then
    echo "エラー: 環境変数 CM_REPO_SLUG が設定されていません。"
    # 代替: REPO_OWNER と REPO_NAME を手動設定
    # REPO_OWNER="your_github_username_or_org"
    # REPO_NAME="your_repo_name"
    # if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then exit 1; fi
    exit 1
else
    REPO_OWNER=$(echo "$CM_REPO_SLUG" | cut -d'/' -f1)
    REPO_NAME=$(echo "$CM_REPO_SLUG" | cut -d'/' -f2)
    echo "INFO: 対象リポジトリ: $REPO_OWNER/$REPO_NAME"
fi

# --- リリースノートファイルのベースパス ---
# Android: android/app/src/main/play/release-notes/{locale}/default.txt
ANDROID_BASE_DIR="android/app/src/main/play/release-notes"
# iOS: ios/fastlane/metadata/{locale}/release_notes.txt or fastlane/metadata/{locale}/release_notes.txt
IOS_BASE_DIR_REL="ios/fastlane/metadata"
IOS_BASE_DIR_ROOT="fastlane/metadata"
IOS_BASE_DIR="" # 後で決定

# iOSのfastlaneディレクトリの場所を確認
if [[ -d "$IOS_BASE_DIR_REL" ]]; then
    IOS_BASE_DIR="$IOS_BASE_DIR_REL"
    echo "INFO: iOS fastlane metadataディレクトリを $IOS_BASE_DIR で検出しました。"
elif [[ -d "$IOS_BASE_DIR_ROOT" ]]; then
    IOS_BASE_DIR="$IOS_BASE_DIR_ROOT"
    echo "INFO: iOS fastlane metadataディレクトリをプロジェクトルート ($IOS_BASE_DIR) で検出しました。"
else
    echo "警告: iOSの標準的なfastlane metadataディレクトリが見つかりません ($IOS_BASE_DIR_REL or $IOS_BASE_DIR_ROOT)。"
    echo "INFO: iOSリリースノートの更新をスキップします。パスを修正するか、ディレクトリを作成してください。"
    # 必要に応じてデフォルトパスを設定し、ディレクトリ作成を試みることも可能
    # IOS_BASE_DIR="$IOS_BASE_DIR_REL"
fi


# --- GitHub APIからリリース説明文を取得 ---
echo "INFO: タグ '$TAG_NAME' のリリース説明文をGitHubから取得しています..."
API_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/tags/$TAG_NAME"

RELEASE_DESCRIPTION=$(curl -s -f -L \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "$API_URL" | jq -r '.body')

if [[ $? -ne 0 ]]; then
    echo "エラー: GitHub APIからのリリース情報の取得または解析に失敗しました。"
    exit 1
fi

if [[ -z "$RELEASE_DESCRIPTION" || "$RELEASE_DESCRIPTION" == "null" ]]; then
  echo "警告: タグ '$TAG_NAME' のリリース説明文が空です。リリースノートファイルは更新されません。"
  exit 0 # 正常終了扱いとする
fi

echo "INFO: リリース説明文を正常に取得しました。言語ごとに解析します..."

# --- 説明文を解析し、各言語のノートをファイルに書き出す ---
# AWKスクリプトで解析: 区切り行を見つけ、ロケールとノート本文を抽出する
# 出力形式: "locale<TAB>notes_body"
parsed_notes=$(echo "$RELEASE_DESCRIPTION" | awk '
BEGIN { current_locale=""; notes=""; first_delimiter_found=0 }
/^--- LANG: ([a-zA-Z0-9_-]+) ---$/ {
    # 前のロケールのノートがあれば出力
    if (current_locale != "") {
        # 先頭と末尾の空白・改行を削除
        gsub(/^[ \t\n]+|[ \t\n]+$/, "", notes);
        if (notes != "") {
            # タブ区切りで出力 (ノート本文にタブが含まれない前提)
            print current_locale "\t" notes
        }
    }
    # 新しいロケールを開始
    # match()関数はGNU Awkで利用可能。標準Awkの場合はsubstr等で抽出
    match($0, /^--- LANG: ([a-zA-Z0-9_-]+) ---$/);
    current_locale = substr($0, RSTART + 10, RLENGTH - 15); # Extract locale code between "--- LANG: " and " ---"
    # current_locale = gensub(/^--- LANG: (.*) ---$/, "\\1", "g", $0); # Alternative using gensub if available
    notes = "";
    first_delimiter_found=1;
    next; # 区切り行自体はノートに含めない
}
# 区切りが見つかった後、次の区切りまでの行をノートとして蓄積
first_delimiter_found == 1 {
    if (notes == "") {
        notes = $0;
    } else {
        notes = notes "\n" $0;
    }
}
END {
    # 最後のロケールのノートを出力
    if (current_locale != "") {
        gsub(/^[ \t\n]+|[ \t\n]+$/, "", notes);
        if (notes != "") {
            print current_locale "\t" notes
        }
    }
}')

# 解析結果を処理
if [[ -z "$parsed_notes" ]]; then
    echo "警告: リリース説明文から有効な言語別ノートが見つかりませんでした ('--- LANG: locale ---' 形式)。"
    exit 0
fi

echo "INFO: 抽出された言語別ノートをファイルに書き込みます..."
processed_count=0
# IFS（内部フィールド区切り文字）をタブに設定して read する
while IFS=$'\t' read -r locale notes_body; do
    if [[ -z "$locale" || -z "$notes_body" ]]; then
        echo "警告: 不正な形式の行をスキップしました: locale='$locale'"
        continue
    fi
    echo "--- 言語: $locale ---"

    # Android ファイルパス生成と書き込み
    android_locale_dir="$ANDROID_BASE_DIR/$locale"
    android_file="$android_locale_dir/default.txt"
    echo "  Android: $android_file"
    mkdir -p "$android_locale_dir"
    echo "$notes_body" > "$android_file"

    # iOS ファイルパス生成と書き込み (ベースディレクトリが存在する場合のみ)
    if [[ -n "$IOS_BASE_DIR" ]]; then
        ios_locale_dir="$IOS_BASE_DIR/$locale"
        ios_file="$ios_locale_dir/release_notes.txt"
        echo "  iOS: $ios_file"
        mkdir -p "$ios_locale_dir"
        echo "$notes_body" > "$ios_file"
    else
        echo "  iOS: スキップ (ベースディレクトリ未確定)"
    fi
    processed_count=$((processed_count + 1))

done <<< "$parsed_notes" # AWKの出力をwhileループに渡す Here String

if [[ $processed_count -gt 0 ]]; then
    echo "INFO: $processed_count 言語のリリースノートを更新しました。"
    echo "INFO: スクリプトが正常に完了しました。"
    exit 0
else
    echo "警告: 処理できる言語別ノートが見つかりませんでした。"
    exit 0 # 正常終了扱い
fi