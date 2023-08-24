# Flutter Photo Upload App

This is a Flutter project created as a code challenge for the Flutter Developer role. The goal of this app is to allow users to capture and upload photos using their device's camera. The app utilizes Riverpod for state management, the CameraAwesome package for camera functionality, and Firebase for photo storage and Firestore for tracking uploads.

This app has support for two languages: English and Spanish. You can change the language on app's settings

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [App Running](#app-running) 

## Getting Started

Follow the instructions below to set up and run the project on your local machine.

## Prerequisites

Before you begin, make sure you have the following prerequisites installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase](https://firebase.google.com/docs/flutter/setup)

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-username/flutter-photo-upload.git
   ```

2. Navigate to the project directory:

   ```bash
   cd flutter-photo-upload
   ```

3. Install the project dependencies:

   ```bash
   flutter pub get
   ```

4. Configure Firebase for your project by running the following command:

   ```bash
   firebase login
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

5. Move the generated `firebase_options.dart` file to the `src` directory.

6. Run the app on your emulator or physical device:

   ```bash
   flutter run
   ```

## Project Structure

The project is structured as follows:

- **lib**: Contains the main Dart code for the Flutter app.
  - **main.dart**: The entry point of the app.
  - **core**: Contains the app's shared content, including services, modules, and utils.
  - **modules**: Contains the app's features.
    - **home_pages.dart**: The main screen with a button to open the camera and a list of uploaded photos.
    - **camera_page.dart**: The camera screen where users can capture and upload photos.
  - **state**: Contains Riverpod providers for state management.
  - **services**: Contains Firebase-related services for photo storage and Firestore interaction.
  - **models**: Defines data models used in the app.
  - **src**: Contains `firebase_options.dart`.
- test: Contains all tests for the project.

## Usage

1. Launch the app on your device.
2. On the home screen, click the "+" button to access the camera screen.
3. Capture a photo using the camera.
4. After capturing a photo, it will be uploaded to Firebase Storage.
5. A document containing information about the upload (e.g., URL, timestamp) will be created in Firestore.
6. Return to the home screen to see a list of all uploaded photos.
7. Preview any image on the list
8. Change app language on Settings

## App running




https://github.com/antonio-nicolau/wish-image-uploader/assets/67912928/f31221df-f2fa-49eb-8083-69892e3bbb5a



https://github.com/antonio-nicolau/wish-image-uploader/assets/67912928/10db6d18-5133-41d5-b451-dcfdf7300b8b




