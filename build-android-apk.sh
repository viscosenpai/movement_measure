#!/bin/sh
set -x
set -e

# TARGET_APP_VERSION
TARGET_APP_VERSION=${1}

# TARGET_VERSION_CODE
TARGET_VERSION_CODE_ARM=${2}
TARGET_VERSION_CODE_ARM64=$(expr ${2} + 1)

# Artifacts Path
OUTPUT_APK_PATH="./artifacts/android"

# cleanを実行
flutter clean

# 依存関係を解決
flutter pub get

# arm用のapkを作成
flutter build apk --release --target-platform=android-arm \
  --build-name=${TARGET_APP_VERSION} --build-number=${TARGET_VERSION_CODE_ARM}

# 成果物をコピー
cp build/app/outputs/apk/release/app-release.apk \
  ${OUTPUT_APK_PATH}/app-release-arm-${TARGET_APP_VERSION}.${TARGET_VERSION_CODE_ARM}.apk

# cleanを実行
flutter clean

# arm64用のapkを作成
flutter build apk --release --target-platform=android-arm64 \
  --build-name=${TARGET_APP_VERSION} --build-number=${TARGET_VERSION_CODE_ARM64}

# 成果物をコピー
cp build/app/outputs/apk/release/app-release.apk \
  ${OUTPUT_APK_PATH}/app-release-arm64-${TARGET_APP_VERSION}.${TARGET_VERSION_CODE_ARM}.apk
