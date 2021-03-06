#!/bin/sh
set -x
set -e

# TARGET_APP_VERSION
TARGET_APP_VERSION=${1}

# TARGET_BUILD_NO
TARGET_BUILD_NO=${2}

# Artifacts Path
OUTPUT_APK_PATH="./artifacts/ios"

# cleanを実行
flutter clean

# 依存関係を解決
flutter pub get

# archiveを作成
# EXPORT_OPTION_PLIST="ExportOptions.plist"
# EXPORT_OPTION_PLIST="ExportOptionsProd.plist"

# flutter buildを実行
# ipa ファイルを作成
# flutter build ios --release \
#   --build-name=${TARGET_APP_VERSION} --build-number=${TARGET_BUILD_NO}

flutter build ipa --release \
  --build-name=${TARGET_APP_VERSION} --build-number=${TARGET_BUILD_NO} \
  --export-options-plist="./ios/ExportOptionsProd.plist"

# cd ios

# xcodebuild -workspace Runner.xcworkspace -scheme Runner -sdk iphoneos \
#   -configuration Release archive -archivePath ../build/Runner.xcarchive

# # ipa ファイルを作成
# xcodebuild -allowProvisioningUpdates -exportArchive \
#   -archivePath ../build/Runner.xcarchive \
#   -exportOptionsPlist ${EXPORT_OPTION_PLIST} -exportPath ../build/ios-release

# cd ..

# 成果物をコピー
cp ./build/ios/ipa/movement_measure.ipa ${OUTPUT_APK_PATH}/app-release-${TARGET_APP_VERSION}.${TARGET_BUILD_NO}.ipa