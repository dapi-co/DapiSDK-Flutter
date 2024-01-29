# DapiSDK-Flutter
This guide will show you how to integrate DapiSDK for Flutter and use its components to interact with the API.


# Dapi Flutter SDK

## Introduction

Dapi for Flutter is a prebuilt SDK that reduces the time it takes to integrate with Dapi's API and gain access to your users financial data.

The SDK provides direct access to Dapi endpoints and offers optional UI to manage users' accounts and money transfer.

## Integration

You can check out our [Flutter Integration Guide](https://docs.dapi.com/docs/flutter-sdk-installation) for detailed information about our SDK.

## Run The Example App

1. Download and install [Flutter, Android Studio with Flutter Plugin, Xcode](https://docs.flutter.dev/get-started/install/macos/desktop?tab=download)
2. Clone the project `git clone https://github.com/dapi-co/DapiSDK-Flutter.git`
3. Open the project in Android Studio
4. Open `lib/main.dart` and replace `APP_KEY` with your appKey. Can be obtained from [Dapi Dashboard](https://dashboard.dapi.com/login)
5. Android:
    * Open `android` project folder in Android Studio and go to `Settings -> Build, Execution, Deployment ->  Build Tools -> Gradle -> Gradle JDK` and select JDK 17 if not selected.
    * Open `build.gradle` and replace applicationId value `com.dapi.app` with your Bundle ID.
    * Sync gradle
6. iOS:
    * Open the `ios` project folder on Xcode.
    * In the Project Navigator, select the project file -> General -> Identity then replace Bundle Identifier value `com.dapi.app` with your Bundle ID
7. Run the app.
8. DapiSDK will start successfully with the correct `AppKey` and `BundleID`.
9. Click `Connect` to select your bank and enter credentials to login through Dapi. You can create a sandbox bank account in your [Dapi Dashboard](https://dashboard.dapi.com/login) project to login in the Sandbox environment.
10. After a successful connection, a DapiConnection object is generated and used for making calls to Dapi endpoints that you can call by clicking on any of the buttons like `Get Identity` and `Create Transfer`.
