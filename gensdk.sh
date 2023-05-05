#!/bin/bash
echo "Generating Android SDK"

if [ -e "android-sdk" ]; then
	rm -rf android-sdk
fi

SDKTOOLS=""

# check Java version
if [[ $( java -version 2>&1 ) == *"1.8.0"* ]]; then
	echo "Using old sdk-tools without Java 11+ support"
	SDKTOOLS="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
	SDKMANAGER="tools/bin/sdkmanager"
else # -version argument is removed
	echo "Using modern commandlinetools with Java 11+ support"
	SDKTOOLS="https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip"
	SDKMANAGER="cmdline-tools/bin/sdkmanager --sdk_root=android-sdk" # /shrug
fi

mkdir android-sdk || exit 1
pushd android-sdk > /dev/null
wget $SDKTOOLS -qO sdktools.zip > /dev/null || exit 1
unzip sdktools.zip || exit 1
rm sdktools.zip || exit 1
popd > /dev/null

echo y | android-sdk/$SDKMANAGER --install "build-tools;33.0.2" "platform-tools" "platforms;android-29"

echo "Now run"
echo "export ANDROID_SDK=\"$PWD/android-sdk\""
