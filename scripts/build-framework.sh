#!/usr/bin/env bash

set -e

BASE_PWD="$PWD"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
OUTPUT_DIR=$( mktemp -d )
COMMON_SETUP="-workspace ${SCRIPT_DIR}/../SwiftyNotifications.xcworkspace -scheme SwiftyNotifications -configuration Release -quiet SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES"

# macOS Catalyst
DERIVED_DATA_PATH=$( mktemp -d )
xcrun xcodebuild build \
	$COMMON_SETUP \
	-derivedDataPath "${DERIVED_DATA_PATH}" \
	-destination 'generic/platform=macOS,variant=Mac Catalyst'

mkdir -p "${OUTPUT_DIR}/maccatalyst"
cp -r "${DERIVED_DATA_PATH}/Build/Products/Release-maccatalyst/SwiftyNotifications.framework" "${OUTPUT_DIR}/maccatalyst"
rm -rf "${DERIVED_DATA_PATH}"

# iOS
DERIVED_DATA_PATH=$( mktemp -d )
xcrun xcodebuild build \
	$COMMON_SETUP \
	-derivedDataPath "${DERIVED_DATA_PATH}" \
	-destination 'generic/platform=iOS'

mkdir -p "${OUTPUT_DIR}/iphoneos"
cp -r "${DERIVED_DATA_PATH}/Build/Products/Release-iphoneos/SwiftyNotifications.framework" "${OUTPUT_DIR}/iphoneos"
rm -rf "${DERIVED_DATA_PATH}"

# iOS Simulator
DERIVED_DATA_PATH=$( mktemp -d )
xcrun xcodebuild build \
	$COMMON_SETUP \
	-derivedDataPath "${DERIVED_DATA_PATH}" \
	-destination 'generic/platform=iOS Simulator'

mkdir -p "${OUTPUT_DIR}/iphonesimulator"
cp -r "${DERIVED_DATA_PATH}/Build/Products/Release-iphonesimulator/SwiftyNotifications.framework" "${OUTPUT_DIR}/iphonesimulator"
rm -rf "${DERIVED_DATA_PATH}"

# XCFRAMEWORK
xcrun xcodebuild -create-xcframework \
	-framework "${OUTPUT_DIR}/iphoneos/SwiftyNotifications.framework" \
	-framework "${OUTPUT_DIR}/iphonesimulator/SwiftyNotifications.framework" \
	-framework "${OUTPUT_DIR}/maccatalyst/SwiftyNotifications.framework" \
	-output ${OUTPUT_DIR}/SwiftyNotifications.xcframework

ditto -c -k --keepParent ${OUTPUT_DIR}/SwiftyNotifications.xcframework SwiftyNotifications.xcframework.zip

echo "✔️ SwiftyNotifications.xcframework"

rm -rf ${OUTPUT_DIR}

cd ${BASE_PWD}
