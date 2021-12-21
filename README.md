# DapiSDK-Flutter
This guide will show you how to integrate DapiSDK for Flutter and use its components to interact with the API.


# Dapi Flutter SDK

## Introduction

Dapi for Flutter is a prebuilt SDK that reduces the time it takes to integrate with Dapi's API and gain access to your users financial data.

The SDK provides direct access to Dapi endpoints and offers optional UI to manage users' accounts and money transfer.

## Integration

You can check out our [Flutter Integration Guide](https://dapi-api.readme.io/docs/how-to-integrate-with-flutter-sdk) for detailed information about our SDK.

## Run The Example App

1. Clone and open the project on Android Studio.
2. Open `main.dart` and replace `APP_KEY` with your appKey. Can be obtained from [Dapi Dashboard](https://dashboard.cf.dapi.co/)
3. For Android, open build.gradle and replace applicationId value `com.dapi.app` with your Bundle ID.
4. For iOS, open the iOS project on xcode and replace Bundle Identifier value `com.dapi.app` with your Bundle ID.
5. Sync the project files and run the app.
6. Click `Start` to initialize DapiSDK.
7. Click `Connect` button to select your bank and enter credentials to login through Dapi.
8. After a successful connection, a DapiConnection object is generated and used for making calls to Dapi endpoints that you can call by clicking on any of the buttons like `Get Identity` and `Create Transfer`.
